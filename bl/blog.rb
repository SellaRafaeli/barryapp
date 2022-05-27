def render_blog_post(post, opts = {})	
	# post[:num_views] ||= num_pageviews(post[:path])
	erb :"/blog/blog_post_template", locals: {post: post}.merge(opts)
end

def post_link(post)
  '/blog/'+post[:title].gsub(' ','-')
end


get '/blog/?:id?' do 
	erb :'blog/blog', default_layout
end

