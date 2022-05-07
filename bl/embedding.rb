def screen_html_by_link(cast)
	link = cast[:link].to_s
	
	if link.starts_with?('https://youtu.be/')
		video_id = link.split('/').last
		html = erb :'vimeo/embed_youtube', locals: {link: video_id}		
	else 
		"<a href='#{link}' target=_blank>#{link}</a>"
	end
end

get '/embedding' do 
end