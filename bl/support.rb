def is_support_cast(cast)
	cast[:support_cast]
end

def user_support_cast_id(user)
	"support_#{user[:_id]}"
end

def ensure_user_support_cast_exists(user)
	id   = user_support_cast_id(user)
	cast = $casts.update_id(id, {last_visit: Time.now, support_cast: true, user_id: user[:_id]}, {upsert: true})
end

get '/support' do 
	require_user
	
	cast = ensure_user_support_cast_exists(cu)

	erb :'/support/chat', default_layout.merge(locals: {cast: cast})
end

get '/support/:handle' do
	require_admin
	user = $users.get(handle: pr[:handle])
	cast = $casts.get(user_support_cast_id(user))

	erb :'/support/chat', default_layout.merge(locals: {cast: cast})
end