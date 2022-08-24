$apps = $mongo.collection('apps')


def run_refresh_apps 
	$apps.delete_many

	apps = []
  apps.each {|app| $apps.add(app) }
end

run_refresh_apps

get '/apps' do 
	erb :'/apps/main', default_layout
end	