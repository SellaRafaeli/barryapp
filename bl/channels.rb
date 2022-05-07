# puts "in methods in channels.rb, address channels alphabetically, please"

def channel_header_msg(channel)	
	return "nowcast: meditation classes"         if @channel == 'meditation'
	return "nowcast: online programming lessons" if @channel == 'programming'
	
	return html_title
	return "live classes"
	return "Online social events for teams"
	return "Online social events"
	return "Online social events and experiences"
	# return "Online social events & freelancers"
	# return "The place for live video events and creators"
	#return "Live video prosrograms and pros"
end

def channel_subheader_msg(channel)
	return 'Learn remote job skills like coding, graphic design, and online marketing from vetted reviewed pros.'
	return 'Live video meditation groups and retreats for all levels' if channel=='meditation'
	return 'Web development lectures and workshops for all levels'    if channel=='programming'
	return 'Online scheduled yoga classes, groups, and retreats.'     if channel=='yoga'
	return 'Pilates, Yoga, Fitness Workouts, and Fitness Groups'      if channel=='sports'

	return 'lectures, classes, courses, webinars, social and team-building experiences, networking and entertainment events'
	#return '<a href="/webinars">Webinars</a>, <a href="/fitness">Fitness</a>, <a href="/teams">Team-Building</a>, <a href="/networking">Networking</a>, <a href="/fun">Entertainment</a>'
	return "Unite and encourage your team with online events they will love<br/>"



	return ""
	return "for online companies and people"

end

Thread.new {
	while true do
		$all_casts = [] #add_user_to_casts($casts.all)
		sleep 5		
	end
}

# def get_channel_subchannels(channel)
# 	return ['yoga', 'pilates', 'dance', 'coaches', 'workouts'] if channel == 'fitness'	
# end

def get_channel_casts(channel, opts = {})
	#return $casts.all(tags: {'$regex': channel}) if (channel == 'homepage' || channel == '')
	
	terms = get_channel_more_terms(channel) 

	# first get casts with tag
	casts = $all_casts.select {|cast| 

		str  = "#{cast['tags']}".to_s.downcase
		res  = terms.any? {|term| str.include?(term) } #if terms.is_a?(Array)
		res  = false if cast_is_hidden(cast)
		res
	}


	if !opts[:must_have_tag]
		# add casts without tag
		casts += $all_casts.select {|cast| 
			user = cast[:user] || {}

			str  = "#{cast['title']} #{cast['desc']} #{cast['tags']} #{user[:location]}".to_s.downcase			
			
			str += user['handle'].to_s 
			#res = str.include?(terms) if terms.is_a?(String)
			res = terms.any? {|term| str.include?(term) } #if terms.is_a?(Array)
			res = false if is_support_cast(cast)
			res = false if is_chat_cast(cast)
			res 
		}
	end

	casts = casts.uniq

	casts = $all_casts.sample(10) if !$prod

	add_user_to_casts(casts)
end

def get_channel_cover_video(channel)
	cover_video = '/video/homepage.mp4'
	
	return '/video/meditation.mp4' if @channel == 'meditation'	
	return '/video/sports.mp4'     if @channel == 'sports'
	
	return cover_video
end

def get_channel_more_terms(channel)
	terms = [channel.to_s.downcase] 
	terms = ['js', 'css', 'web', 'javascript', 'react'] if channel == 'programming'
	terms = ['fitness', 'yoga', 'pilates', 'workout', 'body', 'flexibility', 'stretch'] if (channel == 'fitness') || (channel == 'yoga') || (channel == 'pilates')
	
	return terms
end

def channel_msg1(channel)
	line1 = 'Better teams stick together.'
	line2 = '<small style="text-transform: uppercase">Let\'s find the right event for your team right now.</small>'
	return ("<div style='margin-bottom:10px; color: rgb(51, 51, 51)'>#{line1}</div> #{line2}<span style='display: block; margin-top:10px; position: relative; top:2px; left: 4px'>😊</span>") if !channel
	return "<div style='margin-bottom:10px'>by creators like you,</div> all over the Internet. <span style='display: block; position: relative; top:2px; left: 4px'>😊</span>" if !channel
	return "We're happy you're here. 😊" if !channel

	return "Yoga teachers, guides and coaches." if channel == 'yoga'
	return "Meditation teachers from all over the world." if channel == 'meditation'


	return "Live #{channel} creators and professionals."
end

def channel_msg2(channel)
	return "Work out from home with live coaches and gym-mates." if channel == 'sports' 

	return "And our team will help you with everything. ❤️"
end

get '/refresh' do true end