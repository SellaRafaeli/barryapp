$users = $mongo.collection('users')

$users.indexes.create_one({email: 1}, unique: true) rescue nil
$users.indexes.create_one({city: 1}) rescue nil
$users.indexes.create_one({handle: 1}) rescue nil
$users.indexes.create_one({city: 1, state: 1}) rescue nil
$users.indexes.create_one({zipcodes: 1}) rescue nil

FACETS    = [
    # {icon: 'star', key: 'minority_owned', label: 'Minority-owned'},
    # {icon: 'star', key: 'blm', label: 'BlackLivesMatter'},
    # {icon: 'star', key: 'black_owned', label: 'Black-owned'},
    # {icon: 'star', key: 'lgbt', label: 'pro-LGBT'},
    # {icon: 'star', key: 'lgbt_owned', label: 'LGBT-owned'},
    # {icon: 'star', key: 'delivery', label: 'Delivery'},
    # {icon: 'star', key: '60_min_delivery', label: '60-min-delivery'},
    # {icon: 'star', key: 'same_day_delivery', label: 'same-day-delivery'},
    # {icon: 'star', key: 'edibles', label: 'edibles'},
    # {icon: 'star', key: 'oils', label: 'oils'},
    # {icon: 'star', key: 'mints', label: 'mints'},
    # {icon: 'star', key: 'gummies', label: 'gummies'},    
    {icon: 'star', key: 'dispensary', label: 'Dispensary'},
    {icon: 'star', key: 'brand', label: 'Brand'},
    {icon: 'star', key: 'black_owned', label: 'Professional'},
  ]

RAFAELI_KEYS = [
	'edu_institute_0',
	'edu_achievement_0',
	'edu_date_0',
	'edu_institute_1',
	'edu_achievement_1',
	'edu_date_1',
	'edu_institute_2',
	'edu_achievement_2',
	'edu_date_2',

	'links_name_0',
	'links_val_0',

	'links_name_1',
	'links_val_1',

	'links_name_2',
	'links_val_2',

	'links_name_3',
	'links_val_3',

	'links_name_4',
	'links_val_4',

	'interview_questions_0',
	'interview_answers_0',
	'interview_questions_1',
	'interview_answers_1',
	'interview_questions_2',
	'interview_answers_2',
	'interview_questions_3',
	'interview_answers_3',
	'interview_questions_4',
'interview_answers_4',
]
RAFA_NUM_EDU   = 3
RAFA_NUM_LINKS = 5

USER_KEYS = ["email",  "name", "handle", "img_url", "timezone", 
	"contact_me", "title", "subtitle", "desc", "lang", "country",
	 "location", "my_theme", "media", "payout_info", "tags", 
	 "media_object_fit", "license_url", "license_filename", 'license_numbers', 
	 'license_text', 'delivery_area', 'active', 'contact',
	 'address','city', 'state', 
	 'website',
	 'show_profile_to', 'rate',

	 # buyer fields 
	 'looking_for',
	 'shipping', 'zipcodes', 'ambassador', 'subtype', 'room'] + SOCIAL_NETWORKS + FACETS.mapo(:key) + RAFAELI_KEYS

DEFAULT_IMG_OLD = '/img/profile.png'
DEFAULT_IMG = DEFAULT_PIC = 'https://i.imgur.com/bnxiNtq.png' #'/img/leaf.svg'

def is_seller(user = cu)
	user && user[:type].to_s == 'seller'
end

def is_buyer(user = cu) 
	user && user[:type].to_s == 'buyer'
end

def is_talent(user = cu) 
	user && user[:subtype].to_s == 'talent'
end

def is_team(user = cu)
	user && user[:subtype].to_s == 'team'
end

get '/me' do
	redirect_unless_user

	puts "in me now"
	puts "before rendering me/me, Seconds since time_request_started: #{Time.now - @time_request_started}"
	res = erb :'me/me', default_layout
	puts "after rendering me/me, Seconds since time_request_started: #{Time.now - @time_request_started}"
	res
end

get '/users/:id' do
	user = $users.get(pr[:id])
	redirect user_link(user)
end

get '/me/analytics' do
	redirect_unless_user

	erb :'me/analytics', default_layout
end

get '/create' do
	redirect '/casts/create' if !pr[:k] # to ensure querystring 
	redirect_unless_user

	erb :'/create/create', default_layout
end

get '/my_programs' do 
	erb :'/users/my_programs', default_layout
end

post '/update_me' do	
	FACETS.mapo(:key).each {|key| pr[key] ||= 'off' } # reset facets because only "on" are sent 
	redirect_unless_user

	# gather media input into single array of objects
	pr[:media]         = []
	pr[:media_types] ||= [] #sent alongsides the URLs arr
	pr[:media_img].to_a.each_with_index { |url, idx| pr[:media].push({type: pr[:media_types][idx], url: url}) }

	pr[:zipcodes] = [] #pr[:zipcodes].split(',').map(&:strip).map(&:to_i)
	data = pr.just_keys(USER_KEYS)

	# data[:handle]   = data[:handle].to_s.gsub(/[^0-9A-Za-z]/, '') 
	# data[:timezone] = data[:timezone].to_i
	# if (user = $users.get(handle: data[:handle])) && (user[:_id]!=cuid)
	# 	flash_err 'Handle is taken.'
	# 	redirect '/me'
	# end
	# bp
	user = $users.update_id(cu['_id'],data)
	flash.message = 'Updated!'

	redirect back
end

if !$prod
	get '/sella' do
		redirect '/' if $prod
		return unless !$prod
		session[:user_id] = sella[:_id]
		redirect '/me'
	end
end

get '/logout' do
	session.clear 
	flash.message = 'See you next time!'
	redirect '/'
end

WELCOME_MSG = "Hi, this is mindy. You will be receiving mindful messages from this number. No need to reply. Have a great day. :)"

def reset_all_login_tokens
	$users.all.each {|u| set_login_token(u) }
end

def set_login_token(user)
	$users.update_id(user['_id'], {token: guid})
end

def clean_user(user)
	# public fields available for all
	(user || {}).just(:_id, :img_url, :handle, :verified, :geographic_area, :lang, :desc, :location, :tags)
rescue => e 
	log_e(e)
	{}
end

def verify_signup_data
	if pr[:name] == 'test' || (pr[:email] == 'test')
		foo        = nice_id
		pr[:name]  = Faker::Name.name #{}"Name "+num
		pr[:email] = "email_#{rand}@domain.com"
	end

	email    = pr[:email].to_s.downcase
	password = pr[:password].to_s#.downcase
	name     = pr[:name].to_s#.downcase	

	pr[:type] = :buyer unless pr[:type].to_s == 'seller' 

	if !valid_email(email)
		if pr[:ajax] 
			halt(401,{err: 'Invalid email.'}) 
		else 
			flash_err('Invalid email.') 
			redirect back #'/signup'
		end
	elsif !(email.present? && name.present?)
		if pr[:ajax] 
			halt(401,{err: 'Missing email or name.'})
		else 
			flash_err('Missing email or name.') 
			redirect back # '/signup'
		end
	end

	if email == 'test'		
		$users.delete_one({email: 'test'})
	end

	if (user = $users.get(email: email))
		if pr[:ajax]
			halt(401,{err: 'Email taken. Perhaps try to log in?', goto: "/login?email=#{email}&go_back_to=#{pr[:go_back_to]}"})
		else 
			flash_err('Email taken.')
			redirect '/signup'
		end
	end
end

def add_user
	email    = pr[:email].to_s.downcase	
	password = pr[:password].to_s.downcase
	name     = pr[:name].to_s.downcase
	room     = pr[:room].to_s.downcase

	# state    = pr[:state] || 'NY'
	timezone = (pr[:timezone] || 0).to_i
	
	handle   = $users.available_field('handle', name.split(/@/).first).to_s.strip.downcase

	data = {email: email, name: name, handle: handle, type: pr[:type], subtype: pr[:subtype]}
	# data[:style]    = pr[:style] || DEFAULT_BRAND
	data[:password]   = BCrypt::Password.create(password) if password.present?
	data[:referrer]   = session[EXTERNAL_REFERER] if session[EXTERNAL_REFERER]
	data[:contact_me] = pr[:contact_me].to_s == 'on'
	data[:referrer_id]= pr[:referrer_id] 
	data[:city]     = pr[:city]
	data[:state]    = pr[:state]
	data[:shipping] = pr[:shipping]
	data[:zipcode]  = pr[:zipcode]
	data[:room]     = pr[:room]
	
	u = user = $users.add(data)


	# add_default_casts(user)
	send_welcome_email(user)

	session[:user_id] = user[:_id] 
	if pr[:ajax] 
		{msg: "signed up"}
	else 
		flash.message = "Welcome."
		if pr[:event_title] #signup and create event at once
			redirect "/casts/create?event_title=#{pr[:event_title]}"
		else 
			z=2
		end
	end
end

def user_link(user)
	#bp
	URI.escape ("/@#{user[:handle]}").to_s#.downcase
	#{}"/@#{user[:handle]}"
end

def user_location_for_header(user)
	return user[:location]
	# loc     = ""
	# city    = user[:city].to_s
	# country = user[:country].present? ? (COUNTRIES.find {|c| c[:val] == user[:country] })[:label] : ''
	# if city.present? && country.present?
	# 	"#{city}, #{country}"
	# elsif city.present? || country.present?
	# 	city || country 
	# else
	# 	""
	# end
end

def has_tag(user, tag)
	user[:tags].to_s.downcase.include?(tag.downcase) 
end

def user_type_logo(type)
	if type.to_s == 'seller'
		"<i class='fal fa-store-alt'></i>"
	else
		"<i class='fal fa-child'></i>"
	end
end

post '/signup' do
	verify_signup_data
	res = add_user	
	send_email('sella.rafaeli@gmail.com', 'New user '+res.to_json, 'New user '+res.to_json) rescue nil	
	# res

	redirect '/me'
end

get '/forgot_password' do
	erb :'home/forgot_password', default_layout
end

get '/login' do
	erb :'home/login', default_layout
end

post '/login' do
	email    = pr[:email].to_s.downcase
	password = pr[:password].to_s.downcase
	user = $users.get(email: email)

	if (user) && user[:password].present? && (BCrypt::Password.new(user[:password]) == password)
		session[:user_id] = user[:_id]
		flash.message = 'Welcome back.'
		
		redirect (pr[:go_back_to] ? CGI.unescapeHTML(pr[:go_back_to]) : '/me')
	else
		flash.message = 'Wrong username or password, please try again.'		
		redirect '/me'
	end
end

FB_REDIRECT_URI = $root_url + '/fb_login'
FB_SECRET = ENV['FB_APP_SECRET']

get '/fb_login' do 
	code = pr[:code]
	url  = "https://graph.facebook.com/v4.0/oauth/access_token?client_id=472876716648358&redirect_uri=#{FB_REDIRECT_URI}&client_secret=#{FB_SECRET}&code=#{code}"
	res  = http_get_json(url)
	
	{res: res}
end

get '/signup' do
	erb :'home/signup', default_layout
end

get '/email_login' do
	token = pr[:token]

	if user = $users.get(token: token) 
		session[:user_id] = user[:_id]
		$users.update_id(user[:_id], {last_email_login: Time.now, token: nil})
		flash.message = "Welcome back, #{user[:email]}"
		redirect '/'
	else
		flash.message = 'Token expired, please try again.'
		redirect '/login'
	end
end

post '/beta_signup' do 
	send_email('sella.rafaeli@gmail.com', 'New user '+pr.to_json, 'New user '+pr.to_json) rescue nil	
	flash.message = 'Ok, thanks!'
	redirect '/'
end

## admin
def get_user_chips(user) 
	user[:chips].to_s.split(',')
end