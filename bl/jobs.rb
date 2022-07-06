$jobs = $mongo.collection('jobs')

get '/request_quotes' do 
	erb :'quotes/request_quotes', default_layout
end

post '/job' do 
	$jobs.add(pr)
	flash.message = "Thanks! We'll be in touch."
	redirect '/'
end