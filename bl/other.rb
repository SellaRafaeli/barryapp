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

get '/deck/:code' do 
	code = pr[:code]
	deck_codes = {
		nicole_ibex: true,
		omri_sheva: true
	}.hwia

	if !deck_codes[code] 
		halt(401, "Please contact ir@indydevs.com for access.")
	end

	msg = "deck view: #{code} "+Time.now.to_s
	send_email('sella@indydevs.com', msg, msg)

	send_file(Dir.pwd+'/files/minideck_jul_2.pdf')
	#redirect 'https://docs.google.com/presentation/d/18MxHxayh9YKQ5FIrE04lfYchN5jFrnsSz0mfdhw-GEk/edit?usp=sharing'
end