$threads    = $mongo.collection('threads')
$forum_msgs = $mongo.collection('forums')

get '/forum' do 
	erb :'/forum/forum', default_layout
end

get '/forum/:thread_id' do 
	erb :'/forum/single_thread'
end

post '/forum/threads' do 
	require_user
	title = pr[:title] 
	halt unless title.present? 
	$threads.add(title: title, user_id: cuid, city: pr[:city])
	flash.message = 'Thanks!'
	redirect back
end

post '/forum/:thread_id/msgs' do 
	require_user
	text       = pr[:text] 
	thread_id = pr[:thread_id]
	halt unless text.present? && thread_id.present? 
	$forum_msgs.add(thread_id: thread_id, text: text, user_id: cuid)
	flash.message = 'Thanks!'
	redirect back
end

get '/forum/:thread_id/:thread_title' do 
	erb :'/forum/single_thread', default_layout
end