$casts = $nowcasts = $nc = $ncs = $mongo.collection('casts')

RECURRENCE_SINGLE    = 'single'
RECURRENCE_MULTI     = 'recurring'
RECURRENCE_ON_DEMAND = 'on_demand'

SPECIAL_ITEM             = 'special_item'

CAST_PAY_VARIABLE_AMOUNT = 'variable_amount'

CAST_AMENITIES = [
	{name: 'accreditation', label: 'Accreditation', icon: 'fa-file-certificate'},
	{name: 'curriculum', label: 'Curriculum', icon: 'fa-clipboard-list-check'},
	{name: 'prerecorded_content', label: 'Includes Recorded video', icon: 'fa-file-video'},
	{name: 'homework', label: 'Homework', icon: 'fa-tasks'},
	{name: 'daily',    label: 'Daily Work', icon: 'fa-calendar-day'},
	{name: 'exam',     label: 'Exam', icon: 'fa-alarm-exclamation'},
	# {name: 'zoom',     label: 'Zoom', icon: 'fa-camera-home'},
	# {name: 'skype',    label: 'Skype', icon: 'fa-skype'},
	{name: 'personal', label: 'Option for 1-1', icon: 'fa-people-arrows'},
	{name: 'project',  label: 'Includes Project', icon: 'fa-project-diagram'},
	{name: 'max_class_size',  label: 'Max Class Size', icon: 'fa-users'},
]

CAST_AMENITIES_NAMES   = CAST_AMENITIES.mapo(:name)
CAST_AMENITIES_DETAILS = CAST_AMENITIES_NAMES.map {|name| name+"_details" }

CAST_FIELDS = [
	'user_id',
	'type', #course, class, event, show, special, talk
	'dow', #day of week, mon-sun
	'hour', 
	'mins',
	'length', #in minutes
	'title',
	'cost_dollars',
	'recurrence',
	'datetime',
	'platform',
	'desc',
	'private_notes',
	'link',
	'img_url',	
	'public_video_url',
	'private_video_url',
	'private_passcode',
	'series_start',
	'series_end',
	'special_pay',
	'tags',
	'donation_target',
	'payment_note',
	'custom_time',
	'cta_word',
	'website_html',
	'external_link',
	'ppc',
	'forum_thread_text',
	'faq_titles',
	'faq_answers',
	'media',
	'lang',
	'media_object_fit',
	'privacy',
	'location',
	'product_type',
	'strain',
	'thc'
] + CAST_AMENITIES_NAMES + CAST_AMENITIES_DETAILS

MIN_VARIABLE_AMOUNT = 5

def dow_to_plural(dow)
	dow = dow.to_sym
	return 'Mondays'    if dow == :mon
	return 'Tuesdays'   if dow == :tue
	return 'Wednesdays' if dow == :wed
	return 'Thursdays'  if dow == :thu
	return 'Fridays'    if dow == :fri
	return 'Saturdays'  if dow == :sat
	return 'Sundays'    if dow == :sun
end

def cast_time1(cast, opts = {})
	owner      = $users.get(cast[:user_id])
	owner_name = escape_html(owner[:name])
	offset     = owner[:timezone].to_i

	return cast[:custom_time] if cast[:custom_time].present? 

	if is_on_demand(cast)
		res     = "<span> <!-- on demand --> </span>"		
	elsif is_series(cast)
		mins  = cast[:mins]
		mins  = "00" if mins.to_i == 0
		content = "#{dow_to_plural(cast[:dow])} at #{cast[:hour]}:#{mins}"
		res     = "<span class='cast_time_recurring' data-owner_name='#{owner_name}' data-owner_id=#{cast[:user_id]} data-orig_dow=#{cast[:dow]} data-owner_offset='#{offset}' data-orig_hour=#{cast[:hour]} data-orig_mins=#{cast[:mins]}> #{content}</span>"
	elsif is_single_cast(cast)
		content = nice_datetime(cast[:datetime]).to_s
		res     = "<span class='cast_time_single' data-owner_name='#{owner_name}' data-owner_id=#{cast[:user_id]} data-orig_datetime='#{cast[:datetime]}' data-owner_offset='#{offset}' >#{content}</span>"
	end

	return (opts[:only_content] ? content : res)
rescue => e 
	log_e(e)
	'Unknown time'
end

def can_watch(cast)
	return true if is_chat_cast(cast) && can_watch_chat_cast(cast)
	user_enrolled(cuid, cast) #|| cast[:cost_dollars].to_i == 0 
end

def cast_amenities(cast)
	CAST_AMENITIES.select {|amenity| cast[amenity].present? } 
end

def cast_faqs(cast)
	answers = cast[:faq_answers]
	cast[:faq_titles].to_a.select {|t| t.present? }
end

def is_test_buy(cast)
	return true if cu && (cu[:email].to_s == 'buyer@buyer.com')
	#return true if cast[:tags].to_s.include?('allow_test_buy')

	user = $users.get(cast[:user_id]) || {}

	return true if user[:email].to_s == 'seller@seller.com'

	false
end

def add_default_casts(user)
	data = {
		title: 'One hour meeting',
		recurrence: RECURRENCE_SINGLE,
		cost_dollars: 40,
		user_id: user[:_id]
	}

	$casts.add(data)

	data = {
		title: 'Monthly support',
		recurrence: RECURRENCE_MULTI,
		cost_dollars: 120,
		user_id: user[:_id]
	}

	$casts.add(data)
end

def is_default_img(img_path)
	CGI.unescapeHTML(img_path.to_s) == DEFAULT_PIC
end

def get_cast_img(cast)
	img = cast[:img_url] 
  
  # img = $users.get(cast[:user_id])[:img_url] if !img || is_default_img(img)
  # img = nil if is_default_img(img)

  img
rescue => e 
	log_e(e)
	DEFAULT_PIC
end

def get_custom_img(cast = {})
	get_cast_img(cast)
end

def cast_allows_variable_amount(cast)
	cast[:special_pay] == CAST_PAY_VARIABLE_AMOUNT
end

def cast_next_date_utc(cast)
	return Time.now-1.year if is_on_demand(cast)

	owner = $users.get(cast[:user_id]) || {}
	
	if is_series(cast)
		date = date_of_next(cast[:dow])
		time = date + cast[:hour].to_i.hours + cast[:mins].to_i.minutes - owner[:timezone].to_i.hours
	else
		time = cast[:datetime]
		time = DateTime.parse(time) if time.is_a? String
		# puts time.to_s.red
		# puts time.class
		time - owner[:timezone].to_i.hours
	end
rescue => e 
	log_e(e)
	(Date.today - 1.year).to_datetime
end

def cast_is_soon(cast)
	time = cast_next_date_utc(cast)
	(time > Time.now - 1.hour) && (time < Time.now + 2.weeks)
rescue => e 
	log_e(e)
end

def cast_line(cast)
	price    = cast[:cost_dollars].to_i > 0 ? "$#{cast[:cost_dollars].to_i}" : "Free"
	platform = escape_html(LIVE_PLATFORMS_HASH[cast[:platform]])
	"<span class='cast_line_time'>#{cast_time1(cast)}</span>
	 <span class='cast_line_second_line'><div class='ribbon ribbon-top-right'><span class='cast_line_platform'>#{platform}, </span><span class='cast_line_price'> #{price}</span></div></span>"
end

def cast_is_hidden(cast)
	cast[:privacy]=='hidden' || cast[:tags].to_s.include?(
    'hidden') rescue false 
end

def cast_free(cast)
	cast[:cost_dollars].to_i == 0
end

def is_on_demand(cast)
	cast[:recurrence].to_s == RECURRENCE_ON_DEMAND
end

def is_series(cast)
	return true if is_pro_cast(cast)
	cast[:recurrence].to_s == RECURRENCE_MULTI
end

def is_single_cast(cast)
	cast[:recurrence].to_s == RECURRENCE_SINGLE
end

def is_special_item(cast)
	cast[:type] == SPECIAL_ITEM
end

def is_cast_forum(cast)
	type = FORUM_THREAD.to_s.downcase
	(pr[:type].to_s.downcase == type) || (cast[:type].to_s.downcase == type)
end

def get_cast_hour(cast)
	return cast[:hour].to_i if is_series(cast)
	return Time.parse(cast[:datetime].to_s).hour if is_single_cast(cast) rescue -1
	return -1 # if custom_time
end

def get_cast_dow(cast)
	if is_series(cast)
		return cast[:dow]
	elsif is_single_cast(cast)
		dow_num = Time.parse(cast[:datetime].to_s).wday
	else 
		dow_num = 1 # if custom_time
	end

	return DOWS[dow_num-1][:val]
rescue => e 
	log_e(e)
	'err'
end

def cast_private_passcode_session_key(cast)
	"#{cast[:_id].to_s}_private_passcode"
end

$color_idx = 0

def add_user_to_casts(casts)
	casts.each {|cast| 
		cast[:user] = clean_user($users.get(cast[:user_id])) rescue {}
	}
end

def string_color(string)
	color_idx  = ($color_idx+=1) % 7#string.to_s.size % 7
	puts "color idx is #{$color_idx}".red
  colors     = ['purple','pink','orange','yellow','turquoise','green','blue']
  color      = colors[color_idx]
end

def cast_price(cast)
	num = cast[:cost_dollars]
	if num == 0 
		""
	elsif is_series(cast)
		"$#{num.to_i}/mo"
	else 
		"$#{num}"
	end
end

def cast_trial_cost(cast)
	(cast[:cost_dollars_trial] || (cast[:cost_dollars].to_i/4.0).round).to_f.round
end
	
# $done = false
def show_logistics_overlay(cast)
	# $done = true
	
	return false if is_on_demand(cast)
	return true if cast_price(cast).present?

	return false
end

def cast_logistics_overlay_text(cast)	
	price = cast_price(cast)
	time  = cast_time1(cast)
	
	res = price
	res = cast[:custom_time]+", "+res if cast[:custom_time].present?

	return res

	if is_on_demand(cast)
		time  = ''
	elsif (cast_price(cast).to_i > 0)
		time += ',' 
	end

	return price

	if is_special_item(cast)
		price
	else 
		"<div>			
			<span>#{time} #{price}</span>
			#{(cast[:cost_dollars].to_i>0) && cast[:donation_target].present? ? "<div class='overlay_donation_target'>Proceeds go to #{cast[:donation_target]}</div>" : ""}
		</div>"
	end
rescue => e 
	log_e(e)
	''
end

def cast_link(cast)
	cast_owner = $users.get(cast[:user_id]) || {}
	"#{$root_url}/@#{cast_owner[:handle]}/#{cast[:_id]}/#{cast[:title].to_s.gsub(' ','-')}"
end

def require_cast_owner(cast_id)
	cast    = $casts.get(cast_id) || {}
	user_id = cast[:user_id]
	halt({err: 'cast permissions denied'}) unless (cuid == user_id) || is_admin
end

def is_pro_cast(cast)
	cast[:tags].to_s.downcase.include?(NOWCAST_PRO.downcase)
end

def is_cast_owner(cast)
	cuid == cast[:user_id] rescue false
end

def casts_by_dow_and_hour(casts, dow, hour)
	casts.select { |c| (get_cast_dow(c) == dow) && (get_cast_hour(c) == hour) }
end

get '/pro' do 
	pr[:_id] = ENV['PRO_CAST_ID']
	show_cast_by_id
end

get '/random' do
	redirect "/casts/#{$casts.random[:_id]}"
end

get '/casts/random' do
	redirect "/casts/#{$casts.random[:_id]}"
end

def add_new_cast
	type           = pr[:type]
	data           = {type: type, recurrence: RECURRENCE_SINGLE}
	data[:recurrence] = RECURRENCE_SINGLE if type.to_s == 'special_item' 

	data[:user_id] = cuid
	data[:title]   = "my #{type}"
	data[:title]   = "my cast"
	data[:title]   = "my video" if type == SPECIAL_ITEM
	data[:title]   = pr[:event_title] if pr[:event_title].present?
	data[:cost_dollars] = pr[:cost_dollars].to_i
	data[:dow]     = "tue"
	data[:hour]    = 10
	data[:mins]    = 0 
	data[:length]  = 30

	data[:datetime] = DateTime.now

	res = $nowcasts.add(data)
end

get '/casts/create' do
	erb :'/casts/choose_type', default_layout
	# redirect '/casts/edit/new'
	
	# redirect "/casts/edit/#{res[:_id]}"
	#{type: pr[:type]}
end

get '/casts/edit/:id' do
	require_cast_owner(pr[:id]) unless pr[:id] == 'new'
	erb :'/casts/edit_cast', default_layout
end

post '/casts/edit/:id' do	
	id   = pr[:id]

	CAST_AMENITIES_NAMES.to_a.each { |name| pr[name] ||= false }

	if id == 'new' 
		new_cast = add_new_cast
		id = new_cast[:_id]
	else 
		require_cast_owner(id)
	end

	
	pr[:media] = []
	pr[:media_img].to_a.each_with_index { |url, idx| pr[:media].push({type: pr[:media_types][idx], url: url}) }

	data = pr.just_keys(CAST_FIELDS)
	
	data.delete(:tags) unless is_admin

	[:cost_dollars, :hour, :mins, :length].each { |k| data[k] = data[k].to_i if data[k].present? }

	# puts data

	# data[:user_id] = cuid

	[:datetime].each                  { |f| data[f] = DateTime.parse(pr[f]) if data[f].present? }
	[:series_start, :series_end].each { |f| data[f] = Date.parse(pr[f])     if data[f].present? }
	
	pr[:tags] = pr[:tags].split(',').map(&:strip)
	$casts.update_id(id, data)
	if pr[:ajax] 
		{msg: 'ok'}
	else 
		flash.message = 'Updated.'
		redirect '/casts/'+id
		 #redirect "/me?sec=by_me"
	end
end	

get '/casts/duplicate/:id' do
	require_cast_owner(pr[:id]) 
	cast = $casts.get(pr[:id]).without('_id')
	new_cast = $casts.add(cast)
	flash.message = 'Cast duplicated.'
	redirect '/casts/edit/'+new_cast[:_id]
end

post '/casts/passcode/:id' do
	if (cast = $casts.get(pr[:id])) && (cast[:private_passcode] == pr[:passcode])
		key          = cast_private_passcode_session_key(cast)
		session[key] = pr[:passcode]
		redirect "casts/#{pr[:id]}"
	else 
		flash.message='Wrong passcode.'
		redirect back
	end
end

post '/casts/delete/:id' do 
	id   = pr[:id]
	require_cast_owner(id)
	cast = $casts.get(id)	
	if (cast[:user_id] == cuid) || is_admin
		$casts.delete_one(_id: id)
	end

	{msg: 'Cast deleted.'}
end

post '/pusher/auth/:cast_id' do 	
	halt(403, 'Forbidden (Sign up please)') unless cu #&& (cast = $casts.get(pr[:cast_id])) && can_watch(cast)
	
	# TODO: ensure user is subscribed to this cast. Pass cast_id to this route for that. I do that but there was some bug with it.
	user_data = {
        user_id: cuid, # => required
        user_info: { # => optional - for example
          name: cu[:name],
          img_url: cu[:img_url]
        }
      }
	return $pusher.authenticate(pr[:channel_name], pr[:socket_id], user_data)
end

get '/casts/all' do 
	erb :'casts/schedule/all', default_layout
end

def show_cast_by_id	
	cast_id = pr[:_id]
	cast    = $casts.get(cast_id)

	# redirect CGI.unescapeHTML(cast[:external_link]) if cast[:external_link].present? && cuid!=cast[:user_id]

	@og_cast = cast 
	
	#  $pusher.trigger(cast_chat_channel(cast), 'refresh_tv', {}) rescue nil #tell clients to refresh screen
	@no_container = true if can_watch(cast)

	if ((cast[:user_id] == cuid) || is_admin) && pr[:clear_until]
		clear_cast_chat(cast, pr[:clear_until]) 
		flash.message = 'Messages cleared.'
	end

	$stats.add(type: 'product_view', cast_id: cast_id, buyer_id: cu && cu[:_id], path: _req.path) if cuid!=cast[:user_id] 
	erb :'casts/cast', default_layout
end

# get '/casts/:_id/analytics' do	
# 	require_cast_owner(pr[:_id])
#   cast       = $casts.get(pr[:_id])
#   views      = $cast_clicks.get_many(cast_id: cast[:_id]).to_a.reverse

# 	erb :'casts/analytics', default_layout.merge(locals: {views: views, title: cast[:title]}) 
# end

get '/casts/:_id' do	
#	record_cast_view	
	show_cast_by_id
end

get '/@*/:_id/:cast_title' do
#	record_cast_view
	# @hide_header = true
	show_cast_by_id
end

def record_cast_view
end

get '/@*' do	
  handle = pr['splat'].split('/')[0][0]
  user   = $users.get(handle: handle) || {}

  # @hide_header = true if is_pro(user)

  $stats.add(type: 'store_view', seller_id: user[:_id], buyer_id: cu && cu[:_id], path: _req.path) if cuid!=user[:_id] 
	# record_view({profile_user_id: user[:_id]})
	erb :'users/user', default_layout.merge(locals: {user: user})
end

# get '/casts/:_id/screen' do 
# 	cast = $casts.get(pr[:_id])
# 	halt(401, 'unauthorized') if !can_watch(cast)
# 	erb :'casts/screen_content', locals: {cast: cast}
# end

# post '/casts/:cast_id/action/:action' do
# 	cast_id = pr[:cast_id]
# 	require_cast_owner(cast_id)

# 	cast = $casts.get(cast_id)


# 	html = screen_html_by_link(cast)


# end
