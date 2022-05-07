$requests = $mongo.collection('requests') #track http requests

# $requests.indexes.create_one({created_at: 1}, unique: true) rescue nil
$requests.indexes.create_one({created_at: 1}) rescue nil

def log_request(data)

  data = data.just(:time_took)
  data = data.merge({user_id: cuid, method: _req.env['REQUEST_METHOD'], path: request_path, params: _params})
 	data[:ip] = _req.ip
  data[:headers] = req_headers  

  $requests.add(data) 
rescue => e 
	log_e(e)
end

get '/refresh' do
	true
end