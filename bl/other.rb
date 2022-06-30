get '/cofounder' do 
	erb :'other/cofounder', default_layout
end

get '/coding' do	
	@fullstack = true
	erb :'home/home', default_layout
end

get '/fullstack' do	
	@fullstack = true
	erb :'home/home', default_layout
end

get '/about' do	
	erb :'other/about', default_layout
	# erb :'other/landing_page', default_layout
	# erb :'search/search', default_layout
end

get '/help' do 
	redirect '/about'
end

get '/pricing' do 
	erb :'rafaeli/homepage/pricing', default_layout
end

get '/deck' do 
	code = pr[:code]
	deck_codes = {
		nicole_ibex: true
	}.hwia

	if !deck_codes[code] 
		halt(401, "Please contact ir@indydevs.com for access.")
	end

	msg = "deck view: #{code}"+Time.now.to_s
	send_email('sella@indydevs.com', msg, msg)

	redirect 'https://docs.google.com/presentation/d/1wdm2qpinIsxqPvPWj3pOuPtPkqrhKsy-cClAYHmUE6M/edit?usp=sharing'
end