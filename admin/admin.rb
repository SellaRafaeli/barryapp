manageable_collections = ['stats', 'casts', 'users', 'enrolls', 'locations', 'stripe_customers', 'stripe_notifs', 'single_payments', 'stripe_subscriptions', 'subs', 'analytics', 'errors', 'emails_sent']
#manageable_collections += $mongo.collection_names
manageable_collections.uniq!
manageable_collections.map! {|n| $mongo.collection(n) }

MANAGEABLE_COLLECTIONS = manageable_collections
get '/admin/sellers' do
  erb :'admin/talent', layout: :layout
end

post '/admin/update_talent' do 

  data = {
    help_status: pr[:help_status],
    help_status_date: Time.now
  }

  $users.update_id(pr[:user_id], data)
  redirect '/admin/talent'
end

post '/admin/upload_gdoc_sellers' do 
  path = pr[:file][:tempfile].path
  Thread.new { upsert_users_from_csv(path) }
  flash.message = 'Uploading users, please check for results in a few moments.'
  redirect back
end 

get '/admin/user_page' do
  user = $users.get(_id: pr[:_id])
  erb :'admin/user_page', locals: {user: user}, layout: :layout
end

get '/admin/stats' do 
  erb :'admin/stats', layout: :layout
end

get '/admin/admin_stats' do 
  erb :'admin/admin_stats', default_layout
end 

get '/protected/login_as' do
  user = $users.get(email: pr[:email])
  
  session[:user_id] = user[:_id]
  flash.message = "You are now logged in as #{user[:email]}"
  redirect back
end

get '/protected/enroll_to' do
  cast = $casts.get(pr[:_id])

  enroll_user(cuid, cast[:_id])
  flash.message = "Forced enroll, welcome."
  redirect back
end

get '/admin/give_pro' do
  $users.update_id(pr[:user_id], NOWCAST_PRO => Time.now)
  flash.message = 'Set user to pro'
  redirect back
end

post '/admin/send_msg_now' do
  user = $users.get(email: pr[:email])
  text = pr[:text]
  send_user_msg(user, {force_good_time: true, text: text})
  redirect back
end

get '/admin/dashboard' do
  full_page_card(:"admin/admin_dashboard")  
end

get '/admin/schedule' do
  full_page_card(:"schedule/schedule")  
end

get '/is_admin' do
  #session[:is_admin] = true if params[:foo] = 'bar'
  {is_admin: is_admin}
end

get '/admin/earnings/?:earn_id?' do
  erb :'stripe/all_earnings', default_layout
end

zADMIN_EMAILS = ['abelyael@gmail.com', 'tzlilberlin11@gmail.com', 'sella.rafaeli@gmail.com', 'galweinstock@icloud.com', 'tifrah2008@gmail.com']
ADMIN_EMAILS = ['sella@good-weed.com', 'tifrah2008@gmail.com']
ADMIN_IDS    = ['8FNGN', 'kOdWD', 'XS0xK', 'GMf07', 'grTIU']

def is_admin(user = cu)
  return true if !$prod #&& cu[:email].to_s=='sella.rafaeli@gmail.com'

  cu[:email].in?(ADMIN_EMAILS) #&& cuid.in?(ADMIN_IDS) && admin_authorized?
rescue 
  false
end

get '/admin' do
  redirect '/admin/manage/casts'
  #  to_page(:"admin/dashboard")
  #session[:is_admin] = true
  #redirect '/admin/manage/users'
end

get "/admin/manage/:coll" do 
  erb :"admin/items", default_layout
end 

before '/admin*' do
  protected!  
end

before '/protected*' do #same as /admin/*, just less confusing, to distinguish between admin user and protected routes (the latter needs the HTTP auth)
  protected!  
end

def verify_admin_val(collection, field, val)
  # if you want to verify admin value, you can do it by collection
  # and/or field 
  # mock-code
  # if collection == 'something'
  #   if field == 'something'
  #     halt_bad_input(msg: 'Bad input')

  val
end

post '/admin/create_item' do
  require_fields(['coll'])
  coll = $mongo.collection(params[:coll])
  fields = mongo_coll_keys(coll)
  data   = params.just(fields)
  coll.add(data)
  redirect back
end

post '/admin/update_item' do
  require_fields(['id','field','coll'])
  coll, field, val = params[:coll], params[:field], params[:val]
  verified_val = verify_admin_val(coll, field, val)
  res = $mongo.collection(params[:coll]).update_id(params[:id],{field => verified_val})
  {msg: "ok", new_item: res}
end

post '/admin/delete_item' do
  require_superadmin 
  require_fields(['id','coll'])
  $mongo.collection(params[:coll]).delete_one({_id: params[:id]})
  {msg: "ok"}
end


