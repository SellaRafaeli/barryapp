#
# records calculated earnings per day per seller, from stripe 
#
$earnings = $stripe_earnings = $mongo.collection('stripe_earnings')

def update_todays_payments_data(duration = 1.day)

	case duration
	when 1.month
		start_date   = (DateTime.now).at_beginning_of_month.to_datetime
		prefix = 'monthly_'
	when 1.day

			# take 1 hour ago
		start_date   = (DateTime.now - 1.hour).at_beginning_of_day.to_datetime
		prefix = 'daily_'
	end

	sales_at_time_span  = all_seller_earnings(nil, time: start_date)
	sales        = sales_at_time_span[:all]
	data         = {date: start_date, date_string: start_date.to_s, sales: sales}
	key          = prefix + start_date.to_date.to_s
	$earnings.update_id(key, data, {upsert: true})
end