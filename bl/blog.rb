$blog = $mongo.collection('blog')

get '/blog' do 
	erb :'blog/blog', default_layout
end

get '/blog/:id/:title' do 
	post = $blog.get(pr[:id])
	erb :'blog/single_post', default_layout
end

get '/blog/test' do 
	erb :'blog/editable_post_template'
end

# admin 

post '/admin/blog/new_post' do 
	title  = pr[:title]
	author = pr[:author]
	body   = erb :'blog/editable_post_template'
	
	$blog.add({title: title, orig_title: orig_title, body: body, author: author})
	redirect back
end

post '/admin/blog/edit_post' do 
	id    = pr[:_id]
	title = pr[:title]	
	body  = pr[:body]

	body  = CGI.unescapeHTML(body)
	$blog.update_id(id, title: title, body: body)
	{msg: 'ok'}
end

post '/admin/blog/:id/toggle' do 
	id   = pr[:id]
	post = $blog.get(id)
	$blog.update_id(id, hidden: !post[:hidden])
	redirect back
end