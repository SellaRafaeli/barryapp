$files = $mongo.collection('files')

post '/file' do 
	require_user
	data = {user_id: cuid, name: pr[:name], app_id: pr[:app_id]}
	$files.add(data)
	{msg: 'ok'}
end

post '/files/:id' do 
	file_id = pr[:id]
	file    = $files.get(file_id)
	text    = pr[:text]
	halt unless file[:user_id] == cuid 

	$files.update_id(file_id, text: text)
	{msg: 'ok', text: text}
end

get '/files/:id' do 
	file = $files.get(pr[:id])
	halt unless file && file[:user_id] == cuid 	
	{file: file}
end