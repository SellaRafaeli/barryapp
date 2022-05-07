$users     = $mongo.collection('users')
$users.delete_many(city: '5 Cities')
# $all_users        = $users.all
cities_from_data = [] # $all_users.mapo(:city).uniq.compact
cities_from_data-=['5 Cities']

$cities_by_state = {}

def update_each_state_cities
	$users.all.each {|user| 
		state = user[:state]
		city  = user[:city]
		$cities_by_state[state] ||= []; 
		$cities_by_state[state].push(city) unless $cities_by_state[state].include?(city)
	}; 
	puts 'done update_each_state_cities'
end
# Thread.new { update_each_state_cities; puts $cities_by_state['CA'] }



def areas_get_existing_cities(short_name)
	# full_name is state
	puts "fetching cities for "+short_name
	# short_name = state_to_short(short_name)
	
	# TODO - build hash of state->cities in background, refresh it every 30 seconds in scheduler, here fetch from memory.
	# users  = $users.all.select {|u| u[:state].to_s.downcase == full_name.downcase }
	# users  = $users.all(state: full_name)
	# puts "fetched "+users.count.to_s
	# cities = users.mapo(:city).uniq.sort
	cities = $cities_by_state[short_name].to_a
	cities
end

def state_to_long(two_letters)
	AREAS.select {|state,v| v[:short] == two_letters }.keys[0]
end

def state_to_short(full_name)
	AREAS[full_name.titleize][:short]
end

AREAS = {
	'Alabama': {
		cities: [],
		short: 'AL'
	}, 
	'Alaska': {
		cities: [],
		short: 'AK'
	}, 
	'Arizona': {
		cities: [],
		short: 'AZ'
	}, 
	'Arkansas': {
		cities: [],
		short: 'AR'
	}, 
	'California': {
		cities: [],
		short: 'CA'
	}, 
	'Colorado': {
		cities: [],
		short: 'CO'
	}, 
	'Connecticut': {
		cities: [],
		short: 'CN'
	}, 
	'Delaware': {
		cities: [],
		short: 'DE'
	}, 
	'Florida': {
		cities: [],
		short: 'FL'
	}, 
	'Georgia': {
		cities: [],
		short: 'GE'
	}, 
	'Hawaii': {
		cities: [],
		short: 'HI'
	}, 
	'Idaho': {
		cities: [],
		short: 'ID'
	}, 
	'Illinois': {
		cities: [],
		short: 'IL'
	},
	'Indiana': {
		cities: [],
		short: 'IN'
	}, 
	'Iowa': {
		cities: [],
		short: 'IO'
	}, 
	'Kansas': {
		cities: [],
		short: 'KS'
	}, 
	'Kentucky': {
		cities: [],
		short: 'KY'
	}, 
	'Louisiana': {
		cities: [],
		short: 'LA'
	}, 
	'Maine': {
		cities: [],
		short: 'ME'
	}, 
	'Maryland': {
		cities: [],
		short: 'MD'
	}, 
	'Massachusetts': {
		cities: [],
		short: 'MA'
	}, 
	'Michigan': {
		cities: [],
		short: 'MI'
	}, 
	'Minnesota': {
		cities: [],
		short: 'MN'
	}, 
	'Mississippi': {
		cities: [],
		short: 'MS'
	}, 
	'Missouri': {
		cities: [],
		short: 'MO'
	}, 
	'Montana': {
		cities: [],
		short: 'MT'
	},
	'Nebraska': {
		cities: [],
		short: 'NE'
	}, 
	'Nevada': {
		cities: [],
		short: 'NV'
	}, 
	'New Hampshire': {
		cities: [],
		short: 'NH'
	}, 
	'New Jersey': {
		cities: [],
		short: 'NJ'
	}, 
	'New Mexico': {
		cities: [],
		short: 'NM'
	}, 
	'New York': {
		cities: [],
		short: 'NY'
	}, 
	'North Carolina': {
		cities: [],
		short: 'NC'
	}, 
	'North Dakota': {
		cities: [],
		short: 'ND'
	}, 
	'Ohio': {
		cities: [],
		short: 'OH'
	}, 
	'Oklahoma': {
		cities: [],
		short: 'OK'
	}, 
	'Oregon': {
		cities: [],
		short: 'OR'
	}, 
	'Pennsylvania': {
		cities: [],
		short: 'PA'
	},
	'Rhode Island': {
		cities: [],
		short: 'RI'
	}, 
	'South Carolina': {
		cities: [],
		short: 'SC'
	}, 
	'South Dakota': {
		cities: [],
		short: 'SD'
	}, 
	'Tennessee': {
		cities: [],
		short: 'TE'
	}, 
	'Texas': {
		cities: [],
		short: 'TX'
	}, 
	'Utah': {
		cities: [],
		short: 'UT'
	}, 
	'Vermont': {
		cities: [],
		short: 'VT'
	}, 
	'Virginia': {
		cities: [],
		short: 'VA'
	}, 
	'Washington': {
		cities: [],
		short: 'WA'
	}, 
	'West Virginia': {
		cities: [],
		short: 'WV'
	}, 
	'Wisconsin': {
		cities: [],
		short: 'WI'
	}, 
	'Wyoming': {
		cities: [],
		short: 'WY'
	} 
}.hwia




#SELECT_CITIES_LIST = (SELECT_CA_CITIES + SELECT_CO_CITIES + SELECT_NY_CITIES + cities_from_data).uniq.compact.sort
ALL_STATES         = AREAS.keys
ALL_STATES_SHORT   = AREAS.map {|k,v| v[:short] } 
SELECT_CITIES_LIST = (cities_from_data).uniq.compact.sort - ['5 Cities']
NO_CITY = 'no_city'