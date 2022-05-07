$weed_pics    = ["https://unsplash.com/photos/qcCPIhhdgTw", "https://unsplash.com/photos/2rW8lq0NgPU", "https://unsplash.com/photos/r19PtSh4m7A", "https://unsplash.com/photos/CCbOuWb6CmY", "https://unsplash.com/photos/NxRx7_mPdEk", "https://unsplash.com/photos/fvUv8dLKuSI", "https://unsplash.com/photos/t9jQie6cUhg", "https://unsplash.com/photos/b2haCjfk_cM", "https://unsplash.com/photos/kTQsfFcqJd4", "https://unsplash.com/photos/F8sCVSW4t4E", "https://unsplash.com/photos/-FNGWiOcXaM", "https://unsplash.com/photos/Oaqk7qqNh_c", "https://unsplash.com/photos/PmNjS6b3XP4", "https://unsplash.com/photos/T8gLom6k8Jo", "https://unsplash.com/photos/kTLBgc6tZN0", "https://unsplash.com/photos/J4kK8b9Fgj8", "https://unsplash.com/photos/5NzOfwXoH88"]
$weed_pics    = ['https://imgur.com/fR6gWEV.png']

def get_articles_list
	articles = Dir['./views/articles/**/*.erb'].sort
	res = articles.map {|path|
		articles_folder = path.index('/articles/')
		link  = path[articles_folder..-5]
		topic = link.gsub('/articles/','').split('/')[0]
		link_folder = link.rindex('/')+1
		name = link[link_folder..]    

    {name: name, link: link, topic: topic}
	}
	return res
end
get_articles_list

def article_random_weed_pic_html
	"<span class='article_weed_pic'>
		 <img src='#{$weed_pics.sample}' />
	 </span>"
end

get '/articles' do
	erb :'other/articles', default_layout
end

get '/articles/:topic/:title' do
	html          = erb :"articles/#{pr[:topic]}/#{pr[:title]}"
	erb :"other/article_container", default_layout.merge(locals: {html: html})
end
