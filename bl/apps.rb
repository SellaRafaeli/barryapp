$apps = $mongo.collection('apps')

get '/apps/:id' do 
	erb :'/apps/ide'
end

post '/app' do 
	data           = pr
	data[:user_id] = cuid
	$apps.add(data)
	redirect '/'
end

