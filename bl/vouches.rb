$vouches = $mongo.collection('vouches')

# [{for: 'abc', by: 'def'}]

post '/vouches/:user_id' do
	data = {for: pr[:user_id], by: cuid}

	return redirect back if $vouches.get(data)
	
	$vouches.add(data)
	
	src    = $users.get(cuid)
	target = $users.get(data[:for])
	
	flash.message = 'Thanks for vouching!'

	msg = 'You just received a vouch from '+src[:handle].to_s
	send_email(target[:email], msg, msg)
	redirect back
end