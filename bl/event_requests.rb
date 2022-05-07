$er = $event_requests = $mongo.collection('event_requests')

def add_event_request(data)
	$er.add(data)
end

get '/requests' do
	erb :'/requests/requests'
end