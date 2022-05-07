require './app'
require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

EVERY_DAY_AT_11_AM                = '0 11 * * *' #time is GMT
EVERY_DAY_AT_11_PM                = '0 23 * * *' #time is GMT
EVERY_DAY_AT_1_AM                = '0 1 * * *' #time is GMT

scheduler.every '30m' do
  # daily report
  update_todays_payments_data(1.day)
  # monthly report
	update_todays_payments_data(1.month)
end

scheduler.every '1h' do
	update_expired_enrolls
end

scheduler.cron EVERY_DAY_AT_11_AM do
	# send_reminder_emails_about_tomorrows_casts
end

scheduler.cron EVERY_DAY_AT_11_PM do
	# send_daily_stats_email
end

scheduler.cron EVERY_DAY_AT_1_AM do
	send_daily_report
end

def pr; {}; end 
def session; {}; end 
def cu; nil; end

def send_daily_report
	emails = ['sella@good-weed.co', 'hadar@good-weed.co']
	html   = zerb :'admin/admin_stats', default_layout
	emails.each { |email|
	 send_email(email, 'Good-Weed Admin Stats - '+Time.now.to_s, html) 
	}
end



# scheduler.every '10m' do
# 	remind_users_of_cast_starting_in(10.mins)	
# end

# scheduler.every '210m' do
#   liliya  = all_users[1]  
#   send_user_msg(liliya)
# end

# puts "Mindy Scheduler is now running."
scheduler.join
# EVERY_DAY_AT_5_AM                = '0 5 * * *' #time is GMT
# EVERY_DAY_AT_5_MIN_PAST_EIGHT_PM = '5 20 * * *'
# EVERY_DAY_AT_30_MIN_PAST_TEN_PM  = '30 22 * * *'
# EVERY_DAY_AT_1900                = '0 19 * * *'
# EVERY_MONDAY_AT_NOON             = '00 10 * * mon'

# (see "man 5 crontab" in your terminal)