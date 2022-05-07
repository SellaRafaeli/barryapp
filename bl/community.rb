$ads = $mongo.collection('wanted_ads')

AD_FIELDS = ['user_id', 'user_name', 'text']

get '/community' do 
	erb :'community/community_index', default_layout
end

post '/community/ads/create' do
	require_user 

	data = pr.just(AD_FIELDS)
	data[:user_id]   = cuid
	data[:user_name] = cu[:name] 

	$ads.add(data)

	flash.message = 'Thanks!'
	redirect '/community'
end