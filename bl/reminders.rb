def is_cast_tmw(cast)
	return false if cast['custom_time'].present?
	return false if is_on_demand(cast)
	return true  if is_series(cast) && (cast[:dow] == tmw_day)
	return true  if is_single_cast(cast) && (Date.parse(cast[:datetime].to_s) == Date.tomorrow) rescue false

	return false
end

def send_reminder_email_tmw_casts(user, casts)
	return unless casts.any?
	links = casts.map {|c| "<a href=#{cast_link(c)}>#{cast_link(c)}</a>"}.join('<br/>')
	html  = "Hey, just reminding you about your subscribed casts tomorrow:<br/>#{links}.<br/> See you at the cast! :)"
	#puts "sending to #{user[:email]}: #{html}".yellow
	send_email(user[:email], 'Your subscribed casts tomorrow', html)
end

def send_reminder_emails_about_tomorrows_casts
	$users.all.each do |user|
		tmw_casts = user_enrolled_casts_tmw(user)
		send_reminder_email_tmw_casts(user, tmw_casts) if tmw_casts.any?
	end
	'done'
end

def send_emails_about_unread_msgs
	$users.all.each do |user|
		ouids = get_unread_chats_ouids(cuid, last_msg_after: Time.now - 24.hours)
		if ouids.any? 
			handles = ouids.map {|ouid| ($users.get(ouid) || {})[:handle] }
			html    = "Hey, just letting you know you have unread messages on Nowcast from #{handles.join(',')}. 
			Go to <a href='https://nowcast.co/chat'>https://nowcast.co/chat</a> to view them."
			send_email(user[:email], 'Unread messages on Nowcast', html)
		end
	end
	
	'done'
end

get '/refresh' do true end