require 'rack/protection'

use Rack::Parser, :content_types => {
  'application/json'  => Proc.new { |body| ::MultiJson.decode body }
}

if $prod
  use Rack::SslEnforcer
end

helpers do
  def protected!
    return if admin_authorized? || !$prod
    headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
    halt 401, "Not authorized\n"
  end

  def admin_authorized?
    return true if !$prod
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == [ENV['ADMIN_USERNAME'], ENV['ADMIN_PASSWORD']]
  end
end

def request_expects_json?
  request.xhr? || request.path_info.starts_with?('/api')
end

def print(text)
  console.log(text)
end

def request_is_public?
  request_path.to_s.starts_with?('/css/','/js/','/img/','/favicon/','/HTTP/') rescue false 
end

OPEN_ROUTES = ['/ping', '/fb_enter', '/login', '/about']

def is_open_route
  return true if request_is_public?
  return true if request_path.to_s.in?(OPEN_ROUTES)
  return false
end

use Rack::Protection

def valid_url?(url)
  url.slice(URI::regexp(%w(http https))) == url
end

def validate_params
 # bp
 # if (url = pr[:img_url]).present?
 #    #pr[:img_url] = '/img/profile.png' unless valid_url?(url) && url.starts_with?('https://i.imgur.com/') && url.ends_with?('.png')
 # end
end

def store_external_ref
  referer = request_header('referer')
  if !referer.to_s.starts_with?($root_url)
    session[EXTERNAL_REFERER] = referer 
  end
end

before do
  session[:country] = pr[:country] if pr[:country]

  #require_user unless is_open_route       
  @time_started_request = Time.now    
  # flash.message= ("session ref is "+session[:ref].to_s)
  validate_params

  store_external_ref
  data = {active_at: Time.now}
  data[:af_id] = pr[:af_id] if pr[:af_id].present?
  $users.update_id(cuid,data)
end

get '/headers' do
  {headers: req_headers}
end

def req_headers
  request.env.select { |k,v| k.to_s.starts_with?('HTTP')}
end

def request_header(name)
  request.env['HTTP_'+name.upcase.to_s]
end

def pr
  return @params if @params 
  @params = params rescue {}
end

def cu_token
  token = request_header(:token) || params[:token]
  user  = $users.get(token: token) if token

  if token && !user && !$prod
    user = $users.get(email: 'sella.rafaeli@gmail.com')
  end

  user
end

def cu_session
  session && session[:user_id] && $users.get(session[:user_id]) rescue nil #for tux
  end

def cu
   # return current user
   if request.path_info.starts_with?("/admin")
    @cu = cu_session
   else
    @cu = cu_token || cu_session || nil
  end
end


def cuid
  # current user id
  cu && cu['_id']
end

def request_path
  _req.path rescue nil #for tux
end

def request_fullpath
  _req.fullpath rescue nil #for tux 
end

def _req 
  request rescue OpenStruct.new #allows us to call 'request' safely, including within tux
end

def _params #allows us to call 'params' safely, including within tux
  params rescue {}
end

def is_israel
  return false
  session[:country] == "israel"
end

def heb
  is_israel
end

def is_heb
  return false
  is_israel
end

def is_homepage
  _req.path == '/'
end

get '/country' do
  {country: session[:country]}
end

#get val from params
def params_num(key, opts = {})
  val = params[key]  
  
  return opts[:default] if !val.present? && opts[:default]  

  val = to_numeric(val)
  val = opts[:max] if opts[:max] && val > opts[:max].to_f
  val = opts[:min] if opts[:min] && val < opts[:min].to_f
  return val 
end

def params_val(key, opts = {})
  params[key].present? ? params[key] : ( (opts && opts[:default]) ? opts[:default] : nil )
end

def is_app
  return true if !$prod
  return true if _req.env['HTTP_X_CLIENT'].to_s.in?(['ios','android'])
  # return true if _req.env['HTTP_USER_AGENT'].to_s.downcase.include?('iphone')
  # return true if _req.env['HTTP_USER_AGENT'].to_s.downcase.include?('ipad')
  # return true if _req.env['HTTP_USER_AGENT'].to_s.downcase.include?('android')
  return false 
end

get '/mw/middleware_incoming' do 'refresh this' end