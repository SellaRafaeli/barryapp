$anals = $anal = $analytics = $mongo.collection('analytics')

def record_event(info)
	data = {
		# path: _req.path,
#		unique_cookie_hash: Digest::SHA1.hexdigest(_req.env['HTTP_COOKIE'].to_s),
#		# user_agent: _req.env['HTTP_USER_AGENT'],		
		pr: pr,
	}.merge(info)

	# data[:utm] = pr[:utm] if pr[:utm]
	# data[EXTERNAL_REFERER] = session[EXTERNAL_REFERER] if session[EXTERNAL_REFERER].present?

	$anals.add(data)
rescue => e 
	log_e(e)
end

# def record_pageview
# 	record_event(type: :pageview)
# rescue => e
# 	log_e(e)
# end

# def num_pageviews(path)
# 	$anals.count(path: path)
# end

# get '/refresh' do 	
# end