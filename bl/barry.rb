$tasks = $mongo.collection('tasks')

def show_view(path)
	erb "/#{path}".to_sym
end

get '/barry' do
	view :'/todos'	
end

post '/tasks' do
	$tasks.add(pr)
	redirect back
end

post '/tasks/:id' do 
	$tasks.update_id(pr[:id],{status: 'done'})
end

get '/editor' do
	view(:editor)
end