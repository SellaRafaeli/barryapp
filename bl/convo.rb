$convo_msgs = $mongo.collection('msgs')

# get '/convos/:user_id' do 	
# 	erb :'/convo/convo', default_layout
# end

# get '/convos' do 	
# 	erb :'/convo/convo', default_layout
# end

post '/convo/msgs' do 
	user_ids    = [pr[:target],cuid].sort
	target_user = $users.get(pr[:target])
	$convo_msgs.add(user_ids: user_ids, text: pr[:text], sender: cuid)

	html = "New Message from #{cu[:email]}. See it here: #{$root_url}/convo/#{cuid}"

	send_email(target_user[:email], "New Message from #{cu[:email]}"+Time.now.to_s, html) 
	flash.message = 'added.'
	redirect back
end

