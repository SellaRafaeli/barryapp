$quick_contact = $mongo.collection('quick_contact')

post '/quick_contact' do
	pr[:ip]       = _req.ip
	pr[:location] = location_by_ip(_req.ip) if $prod
	$quick_contact.add(pr)		
	subj = "User quick-contact request: #{pr[:contact]}"
	html = pr.to_json

	send_email('sella@good-weed.co', subj, html)
	# send_email('yael@nowcast.co', subj, html) if $prod
	
	redirect '/fullstack?quick_contact=yes'
end
