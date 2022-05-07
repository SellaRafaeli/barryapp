$area_posts = $mongo.collection('area_posts')

post '/area_posts/submit' do 
	if !cu 
		flash.message = 'Sign up first.'
		redirect '/signup' 
	end

	data = {user_id: cuid, handle: cu[:handle], text: pr[:text], city: pr[:city], state: pr[:state]}
	$area_posts.add(data)
	flash.message = 'Thanks'
	redirect back
end

post '/area_posts/delete/:id' do 
	post = $area_posts.get(pr[:id])
	if (post[:user_id] == cuid) || ($prod && is_admin)
		$area_posts.delete_one(_id: post[:_id])
		flash.message = 'Deleted post.'
		redirect back
	end
	
	flash.message = 'Error deleting post'
	redirect back	
end