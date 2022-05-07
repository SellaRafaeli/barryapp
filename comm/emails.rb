$emails_sent     = $mongo.collection('emails_sent')
$postmark_client = Postmark::ApiClient.new(ENV['POSTMARK_API_TOKEN'])

# emails we have (make sure all are in the QA doc)
# - on signup         
# - on forgot password 

# emails we need
# - 24 hours before cast (viewer or owner)
# - 1 hour before cast (viewer or owner)
# on enrollment, to cast owner 
# on enrollment, to viewer 
# on payment, to viewer
# on payment, to cast owner?

EMAILS_ON     = ENV['EMAILS_ON'].to_s == 'yes'
EMAILS_FROM   = 'hi@good-weed.com' # more "from" emails can be added on Postmark

def send_email(to, subj, html_body, opts = {})
  res = 'unset'
  if EMAILS_ON
    res = $postmark_client.deliver(
      from: opts[:from] || EMAILS_FROM,
      to: to,
      subject: subj,
      html_body: html_body,
      track_opens: true
    )
  else 
    puts "Skipping email subject: #{subj} because !EMAILS_ON".red    
  end

  $emails_sent.add(to: to, subj: subj, html_body: html_body, opts: opts, res: res)
rescue => e
  puts e.to_s.red
  log_e(e)
  false
end

# def send_login_sms(user)
# 	token = guid
# 	$users.update_id(user[:_id], {token: token})
# 	msg = "Hi, click here to log in: #{$root_url}/email_login?token=#{token}"
# 	twilio_send(msg, user[:num])
# end

def update_user_token(user)
  token = guid
  $users.update_id(user[:_id], token: token)
  token
end

def send_welcome_email(user)
  # token = update_user_token(user)
  # url   = "#{$root_url}/email_login?token=#{token}"
  send_email(user[:email], "Hey #{user[:name]}, welcome to nowcast", email_by_view('welcome'))  
rescue => e 
  log_e(e)
end

post '/emails/forgot_password' do 
  email = pr[:email]
  record_event(event: :forgot_password, email: email)
  if email.present? && $users.get(email: email)
    send_login_email(email)
    {ok: 'ok'}
  else 
    {err: 'no such user'}
  end
end

def send_login_email(email)
  if (user = $users.get(email: email)) 
    token = update_user_token(user)
    url   = "#{$root_url}/email_login?token=#{token}"    
    msg    = "Hi, somebody told us you forgot your password to nowcast. You can click here to log in: #{url}"
    send_email(user[:email], "nowcast login link", msg)
  end
end
# def send_default_email #for testing
#   subj = "test subject #{Time.now}"
#   send_email('sella.rafaeli@gmail.com', subj, '<strong>Hello</strong> dear Postmark user.')
# end
def email_by_view(view, opts = {})
  erb :"/emails/#{view}", locals: opts
end

def send_daily_stats_email(target_emails = ADMIN_EMAILS)
  # send_email(to, subj, html_body, opts = {})
  #target_emails = ['sella.rafaeli@gmail.com']
  target_emails.each do |email|
    body = zerb(:'admin/stats')
    link = "#{$root_url}/admin/stats"
    body+="<br/><br/> view more at <a href='#{link}'>#{link}</a>"
    date = DateTime.now.strftime("%b %d")
    subj = "Nowcast.co admin stats for #{date}"
    send_email(email, subj, body)
  end
end

# get '/emails/enrollment_welcome' do 
#   cast = $casts.last
#   email_by_view('enrollment_welcome', cast: cast)  
# end

get '/emails/enrollment_welcome' do 
  cast  = $casts.last
  owner = $users.random
  viewer = $users.random
  email_by_view('enrollment_welcome', cast: cast, viewer: viewer, owner: owner)  
end

get '/emails/:view' do 
  email_by_view(pr[:view])  
end