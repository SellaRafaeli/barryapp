# $cast_video = $mongo.collection('cast_video')

# post '/cast_video/desc' do
# 	cast_id = pr[:cast_id]
# 	cast    = $casts.get(cast_id)
	
# 	cast_video = $cast_video.get({cast_id: cast_id})
# 	if cast_video
# 		$cast_video.update_id(cast_video[:_id], {"#{cuid}_desc": pr[:desc]})
# 	else 
# 		$cast_video.add({cast_id: cast_id, "#{cuid}_desc": pr[:desc]})
# 	end
	
# 	$pusher.trigger(cast_chat_channel(cast), 'refresh-rtc-descs', {})
# 	{msg: 'ok'}
# end

# get '/cast_video/descs' do 
# 	cast_id = (CGI.unescapeHTML(pr[:cast_id])[1..-2])
# 	descs = $cast_video.get(cast_id: cast_id)
# 	descs.delete(cuid)
# 	data = {descs: descs}
# 	data
# end