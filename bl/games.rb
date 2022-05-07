$games = $mongo.collection('games')

GAME_FIELDS = [
	'cast_id',
	'board', #2D array
	'users' #hash {abc: {location: [2,5]}}
]

# cast games

def game_default_board
	board = (0..9).to_a.map {|row_idx| 
		(0..9).to_a.map {|col_idx| 
			{'background-color': ['green','blue','pink'].sample } 
		}
	}
end

def get_cast_game(cast_id)	
	$games.get(cast_id: cast_id) || $games.add(cast_id: cast_id, board: game_default_board, users: {}) 
end

post '/casts/game/move/:cast_id' do 
	require_user
	# a: update game state 
	cast_id = pr[:cast_id]
	game    = get_cast_game(cast_id) # {board: ..., users: {abc: {}}}

	board   = game[:board]
	game_users = game[:users]

	game_users[cuid]           = (game_users[cuid] || {}).merge(clean_user(cu))

	current_user_location = game_users[cuid][:location] || [rand(board.size),rand(board.size)]

	x = current_user_location[0]
	y = current_user_location[1]
	
	move = pr[:move]

	x = x-1 if move == 'up' 
	x = x+1 if move == 'down' 
	y = y-1 if move == 'left'  	
	y = y+1 if move == 'right'

	if (x>=0) && (x<board.size) && (x<board[0].size) && (y>=0) && (y<board.size) && (y<board[0].size)
		game_users[cuid][:location] = [x,y]
	end
	
	$games.update_id(game[:_id], users: game_users)
	# b: notify via pusher all game viewers

	return {cast_id: pr[:cast_id], move: move, game: $games.get(game[:_id])}
end

get '/games/:cast_id' do
	{game: $games.get(cast_id: pr[:cast_id])}
end