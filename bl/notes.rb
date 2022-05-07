$notes = $mongo.collection('notes')

post '/notes' do 
	data = pr
	data[:user_id] = cuid
	data[:handle] = cu[:handle]
	$notes.add(data)
	{msg: 'ok'}
end