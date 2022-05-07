$cast_clicks = $mongo.collection('cast_clicks')

EXTERNAL_REFERER  = :external_referer # https://www.reddit.com/r/ProgrammerHumor/comments/6hbpyl
CAST_CLICK_FIELDS = ['external_link', 'ppc']

def location_by_ip(ip)
	res      = http_get_json("http://ip-api.com/json/#{ip}").hwia
	location = "#{res[:city]}, #{res[:regionName]}, #{res[:country]}"
end

def record_view(data)
	handle   = (cu || {})[:handle]

	ip       = _req.ip
	location = location_by_ip(ip)
	data     = data.merge({handle: handle, user_id: cuid, params: _params, headers: req_headers, ip: ip, location: location})
	data[EXTERNAL_REFERER] = session[EXTERNAL_REFERER] if session[EXTERNAL_REFERER].present?
	data[:user] = cu[:_id] if cu
	$cast_clicks.add(data)
end