EMPTY_TERMS = ['lesson', 'class', 'course', 'teacher', 'expert', 'tutor']

def cleanup_search(src)
	EMPTY_TERMS.each do |term|
		src = src.to_s.gsub(term+'s','').to_s.gsub(term+'es','').to_s.gsub(term,'')
	end	

	src
end

get '/search/autocomplete' do 
	users = $users.all.map {|u| 
		{name: u[:handle].to_s, url: user_link(u), img_url: u[:img_url] || DEFAULT_IMG}
	}

	res = [{"name": "foo-afghanistan"}, {"name": "ALBANIA"}, {"name": "ALGERIA"}, {"name": "AMERICAN SAMOA"}, {"name": "ANDORRA"} ]
	
	res = users
	{res: res}
end