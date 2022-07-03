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

def is_verified(u)
	u[:tags].to_s.downcase.include?('verified')
end

def search_user_score(u, search_val)
	return is_verified(u).to_s
	score = 0
	
	score+= 20000 if u[:img_url].present? && !u[:img_url].to_s.include?('profile.png')
	score+= 20 if u[:name].present? 
	score+= 20 if u[:title].present? 
	score+= 20 if u[:desc].present? 
	score+= 20 if u[:location].present? 

	# 5.times do |i|
	# 	i = i.to_s
	# 	score += 10 if u['edu_achievement_'+i].present? 
	# 	score += 20 if u['links_val_'+i].present? 
	# 	score += 30 if u['interview_answers_'+i].present? 
	# end

	puts "img_url: #{u[:img_url]}, score: #{score}"
	u[:score] = score
	return score
end