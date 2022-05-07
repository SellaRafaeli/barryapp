# enrollment is like an "order"
$enrolls = $enrollment = $mongo.collection('enrollment')

ENROLL_ACTIVE   = 'new'
ENROLL_CANCELED = 'canceled'

# user_id - enrolling user
# cast_id - enrolled cast

ENROLL_FIELDS = ['user_id', 'cast_id', 'status', 'amount']

def enroll_user(user_id, cast_id, data = {})
	buyer_id       = user_id
	data[:user_id] = user_id
	data[:cast_id] = cast_id
	data[:status]  = ENROLL_ACTIVE

	if enroll = $enrolls.get(user_id: user_id, cast_id: cast_id)
		$enrolls.update_id(enroll[:_id], data)
	else 
		$enrolls.add(data)
	end	
	
	cast = $casts.get(cast_id)
	if is_pro_cast(cast) 
		$users.update_id(user_id, NOWCAST_PRO: Time.now) 
		html = "data: #{data.to_json}, cast_id: #{cast_id}"
		Thread.new { send_email('sella@good-weed.com', "pro purchase: #{buyer_id}"+Time.now.to_s, html) }
	end

	send_enrollment_emails(user_id, cast_id)

	add_user_as_customer(user_id, cast_id)	
rescue => e 
	log_e(e)
end

def add_user_as_customer(buyer_id, cast_id)
	seller_id = $casts.get(cast_id)[:user_id]
	seller = $users.get(seller_id)

	$customers.add(buyer_id, seller)
end

def user_enrolled(user_id, cast)
	# return true if cast[:user_id] == user_id #owner
	return false unless user_id.present?
	$enrolls.get(user_id: user_id, cast_id: cast[:_id], status: ENROLL_ACTIVE) 
rescue => e 
	puts e.to_s.red
	log_e(e)
	false
end

def users_enrolled_in_cast(cast)
	cast_id = cast[:_id]
	enrolls = $enrolls.get_many(cast_id: cast_id, status: ENROLL_ACTIVE) 
	users   = enrolls.map {|enroll| 
		user = $users.get(enroll[:user_id])
		user[:enroll] = enroll 
		user
	}.uniq
	users
end

def casts_for_user(user_id)
	enrolls = $enrolls.get_many(user_id: user_id, status: ENROLL_ACTIVE) 
	casts   = enrolls.map {|enroll| $casts.get(enroll[:cast_id]) }.compact
	casts
end

def my_buys(user_id)
	enrolls  = $enrolls.get_many(user_id: user_id)
end

def my_sales(user_id)
	cast_ids = $casts.all(user_id: user_id).to_a.mapo(:_id)
	enrolls  = cast_ids.map {|cast_id| $enrolls.get_many(cast_id: cast_id)  }.flatten
end

def send_enrollment_emails(user_id, cast_id)
	viewer = $users.get(user_id)
	cast   = $casts.get(cast_id)
	owner  = $users.get(cast[:user_id])

	# notify viewer
	html = email_by_view('enrollment_welcome', cast: cast, viewer: viewer, owner: owner)
	send_email(viewer[:email], "Thanks for ordering '#{cast['title']}!'", html)

	# notify owner
	html = email_by_view('enrollment_inform_owner', cast: cast, viewer: viewer, owner: owner)
	send_email(owner[:email], "New order for '#{cast['title']}: #{viewer['name']}'", html)
end

def cancel_enroll(enroll)
	$enrolls.update_id(enroll[:_id], canceled_at: Time.now, status: ENROLL_CANCELED)
	if (stripe_sub_id = enroll[:sub_id] || enroll[:stripe_sub_id])
		cancel_stripe_sub(stripe_sub_id)
	end

	cast = $casts.get(enroll[:cast_id]) 
	if (cast && cast[:tags].to_s.include?(NOWCAST_PRO))
		$users.update_one({_id: cuid}, {'$unset': {NOWCAST_PRO => 1}})
	end
rescue => e
	log_e(e)
	false
end

def update_expired_enrolls(time = Time.now)
	old_enrolls = $enrolls.all(expires_at: {'$lt': time})
	old_enrolls.each {|enroll| 
		cancel_enroll(enroll[:_id])
	}
end

post '/enrollment/cancel' do 
	require_user
	
	enroll = $enrolls.get(user_id: cuid, cast_id: pr[:cast_id], status: ENROLL_ACTIVE)
	
	if enroll
		cancel_enroll(enroll)
		{msg: 'ok'}
	else 
		halt(404,{err: 'No such enrollment'})
	end
end

post '/enrolls' do #create an order out of thin air, by the seller
	require_user 

	cast   = $casts.get_many(user_id: cuid).sample
	halt(400, {err: 'You must create a product first. No orders with no product.'}) unless cast

	cast_id = cast[:_id]
	enroll = $enrolls.add(user_id: nil, cast_id: cast_id, status: ENROLL_ACTIVE)	
	html   = erb :'orders/single_order', locals: {order: enroll, is_seller: true}
	{enroll: enroll, html: html}
end

post '/cashless_enroll' do 

	require_user
	require_fields(['cast_id', 'name', 'address', 'phone'])

	cast = $casts.get(pr[:cast_id])
	halt unless cast
	data = pr.just(:cast_id, :name, :address, :phone)
	data[:user_id] = cuid
	data[:amount] = cast[:cost_dollars]

	$enrolls.add(data)
	flash.message = 'Your order has been placed.'
	#{msg: 'ok'}
	redirect '/me?sec=for_me'
end

post '/enrolls/:id' do 
	require_user
	
	# halt unless pr[:status]
	enroll = $enrolls.get(pr[:id])
	cast   = $casts.get(enroll[:cast_id])
	owner  = cast[:user_id]
	halt unless owner == cuid

	enroll = $enrolls.update_id(pr[:id], pr)
end

post '/joinFree' do 
	cast_id = pr[:cast_id]
	cast    = $casts.get(cast_id)
	halt(401, {err: 'not free'}) if !(cast_free(cast) || cast_allows_variable_amount(cast))

	# if no user, force signup, If user exists, just enroll.
	verify_signup_data if !cu
	add_user if !cu
	enroll_user(cuid, cast_id)
	{msg: 'ok'}
end