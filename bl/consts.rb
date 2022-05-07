LOGOS = [
  'logo_fb.png',
  'logo_zoom.jpg',
  'logo_youtube.png',  
  'logo_instagram.jpg',
  # 'logo_vimeo.png',
]

DOWS = [    
  {val: 'mon', label: 'Mondays'},
  {val: 'tue', label: 'Tuesdays'},
  {val: 'wed', label: 'Wednesdays'},
  {val: 'thu', label: 'Thursdays'},
  {val: 'fri', label: 'Fridays'},
  {val: 'sat', label: 'Saturdays'},
  {val: 'sun', label: 'Sundays'},
]

def dow_idx(dow) 
  DOWS.index {|d| d[:val] == dow.to_s }
end

def cur_day
  Date::ABBR_DAYNAMES[Date.today.wday].downcase
end

def tmw_day
  Date::ABBR_DAYNAMES[Date.today.wday+1].downcase
end

LIVE_PLATFORMS = [    
  {val: 'google_meet', label: 'Google Meet'},
  {val: 'zoom', label: 'Zoom'},
  {val: 'vimeo', label: 'Vimeo'},
  {val: 'fb', label: 'Facebook Messenger Room'},
  {val: 'yt', label: 'YouTube Live'},
  {val: 'custom_platform', label: 'Custom Platform'}
]

LIVE_PLATFORMS_HASH = { }
LIVE_PLATFORMS.each { |i| LIVE_PLATFORMS_HASH[i[:val]] = i[:label] }

# * For Beginners 
# - Coding 101
# - Introduction to Software Development 
# - SheCodes: Coding Workshops for Women
# - Web Apps 101 

# * Fullstack Bootcamps 
# - Zero to Portfolio Bootcamp
# - Flatirons 

# * Web Application Development (Frontend)
# - Fullstack development 101 
# - Advanced CSS 
# - Mastering Web App Development 
# - React 101
# - Vue 101
# - Angular 101 
# - Advanced JS 
# - Advanced CSS

# * Web Servers (Backend) 
# - Ruby & Rails: #1 Framework of Web Apps 
# - Ruby & Sinatra: Developer Happiness 
# - NodeJS 101 
# - Python 101 

# * For Kids 
# * Mind & Body

# Coming soon:
# * Data Science, UI/UX, Product Management 
# * Algorithms, AI, Machine Learning, NLP


# Web Application Development 
# * Web App Development 101  
# * JavaScript Dojo
# * Hello World to Portfolio - a 30-day Bootcamp 
# * Ruby - The Language for Happy Developers 

# Cybersecurity 
# * Intro to Cybersecurity 
# * How Hackers Work 
# * How to Make a Website Security Audit 
# * How to Become a Penetration Tester 

# Online Marketing
# * Online Marketing for Beginners 
# * 

# Data Science 
# * What is Data Science?

HOMEPAGE_TOPICS = [  
  # {topic: 'Top-Rated', tag: 'toprated'},
  #{topic: 'Coding for Beginners', tag: 'beginners'},
  {topic: 'Mind, Body & Art', tag: 'art', subtopics: ['Fitness']},
#  {topic: 'Fullstack', tag: 'bootcamp'},
  #{topic: 'Frontend', tag: 'frontend', subtopics: ['JavaScript', 'CSS', 'React', 'Vue', 'Angular']},
  #{topic: 'Backend', tag: 'backend', subtopics: ['Ruby', 'NodeJS', 'Python']},
  # {topic: 'Soft Skills', tag: 'soft_skills', subtopics: ['Job Searching', 'Interviewing', 'Software Professionalism']},
  
  # {topic: 'Cybersecurity'},
  # {topic: 'Online Marketing'},
  # {topic: 'Data Science'},
  # {topic: 'UX Design'},
  # {topic: 'Graphic Design'},
  # {topic: 'Product Management'}
]

SAMPLE_SEARCHES = [
  {label: 'Fitness coaches', v:nil },
  {label: 'Dance lessons', v:nil },
  {label: 'Yoga teachers', v:nil },
  {label: 'Actors', v:nil },
  {label: 'Aerobics teachers', v:nil },
  {label: 'Storytellers', v:nil },
  {label: 'Consultants', v:nil },
  {label: 'Therapists', v:nil },
  {label: 'Coaches', v:nil },
  {label: 'Meditation teachers', v:nil },
  {label: 'Public speakers', v:nil },
  {label: 'Entertainers', v:nil },
  {label: 'Comedians', v:nil },
  {label: 'Musicians', v:nil },
  {label: 'Graphic Designers', v:nil },
  {label: 'Video editors', v:nil },
  {label: 'Content editors', v:nil },
  {label: 'Domain experts', v:nil },
  {label: 'English teachers', v:nil },
  {label: 'Spanish teachers', v:nil },
  {label: 'Chinese teachers', v:nil },
]

TIME_ZONES = [
  {val:-12, label: 'UTC/GMT -12:00 (Baker Island, Howland Island)'},
  {val:-11, label: 'UTC/GMT -11:00 (American Samoa, Niue NZ)'},
  {val:-10, label: 'UTC/GMT -10:00 (Honolulu, Cook Islands NZ)'},
  {val:-9, label: 'UTC/GMT -09:00 (Anchorage, French Polynesia)'},
  {val:-8, label: 'UTC/GMT -08:00 (San Francisco, Los Angeles, Vancouver, Tijuana)'},
  {val:-7, label: 'UTC/GMT -07:00 (Phoenix, Calgary, Ciudad Juarez)'},
  {val:-6, label: 'UTC/GMT -06:00 (Mexico City, Chicago, Guatemala City, Winnipeg, San José, San Salvador)'},
  {val:-5, label: 'UTC/GMT -05:00 (New York, Toronto, Havana, Lima, Bogotá)'},
  {val:-4, label: 'UTC/GMT -04:00 (Santiago, Santo Domingo, Manaus, La Paz, Halifax)'},  
  {val:-3, label: 'UTC/GMT -03:00 (São Paulo, Buenos Aires)'},
  {val:-2, label: 'UTC/GMT -02:00 (Fernando de Noronha, South Georgia)'},
  {val:-1, label: 'UTC/GMT -01:00 (Cape Verde, Ittoqqortoormiit Greenland)'},
  {val: 0, label: 'UTC/GMT +00:00 (London, Dublin, Lisbon, Dakar)'},
  {val: 1, label: 'UTC/GMT +01:00 (Berlin, Rome, Paris, Madrid, Warsaw, Casablanca)'},  
  {val: 2, label: 'UTC/GMT +02:00 (Cairo, Johannesburg, Khartoum, Kiev, Athens, Jerusalem)'},
  {val: 3, label: 'UTC/GMT +03:00 (Moscow, Istanbul, Baghdad, Addis Ababa, Doha)'},
  {val: 4, label: 'UTC/GMT +04:00 (Dubai, Baku, Tbilisi)'},
  {val: 5, label: 'UTC/GMT +05:00 (Karachi, Tashkent)'},
  {val: 6, label: 'UTC/GMT +06:00 (Dhaka, Almaty, Omsk)'},
  {val: 7, label: 'UTC/GMT +07:00 (Bangkok, Krasnoyarsk)'},
  {val: 8, label: 'UTC/GMT +08:00 (Shanghai, Taipei, Kuala Lumpur, Singapore, Perth, Manila)'},
  {val: 9, label: 'UTC/GMT +09:00 (Tokyo, Seoul, Pyongyang)'},
  {val: 10, label: 'UTC/GMT +10:00 (Sydney, Port Moresby, Vladivostok)'},
  {val: 11, label: 'UTC/GMT +11:00 (Norfolk Island, Sakha Republic, Solomon Islands)'},
  {val: 12, label: 'UTC/GMT +12:00 (Auckland, Petropavlovsk-Kamchatsky)'}
]

USER_PAGE_THEMES = [
  {val: '', label: 'Default'},
  {val: 'playful', label: 'Playful'}
]

GEOGRAPHIC_AREAS = [
  {val: 'bay_area',     label: 'San Francisco & Bay Area'},
  {val: 'los_angeles',  label: 'Los Angeles'},
  {val: 'portland',     label: 'Portland'},
  {val: 'seattle',      label: 'Seattle'},
  {val: 'tel_aviv',     label: 'Tel Aviv'},
  {val: 'israel',     label: 'Israel'},
  {val: 'nyc',     label: 'New York City'},
  {val: 'mexico_city',  label: 'Mexico City'},
  {val: 'italy',  label: 'Italy'},
  {val: 'united_kingdom'  ,  label: 'United Kingdom'},
].sort_by {|area| area[:label] }

US_STATES = [
  {val: 'CA',    label: 'California'},
  {val: 'WA',    label: 'Washington'},
  {val: 'OR',    label: 'Oregon'},
  {val: 'NY',    label: 'New York'},
]

US_STATES_CITIES = {
    'California': ['San Francisco', 'San Jose', 'Los Angeles', 'San Diego'].sort,        
    'Colorado': ['Boulder', 'Denver'].sort,        
    'Massachusetts': ['Boston'].sort,
    #'Nevada': ['Reno', 'Las Vegas', 'Carson City'].sort,
    'New York': ['New York City'].sort,
    # 'New Jersey': ['New Jersey'].sort,
    'Oregon': ['Portland', 'Bend'].sort,
    'Washington': ['Seattle'].sort,
    'Israel': ['Tel Aviv']
  }

# https://www.britannica.com/topic/list-of-cities-and-towns-in-the-United-States-2023068#ref326624
zSELECT_STATES_LIST = ['CA', 'CO', 'NY']
SELECT_STATES_LIST = 
SELECT_CA_CITIES = ['Alameda', 'Alhambra', 'Anaheim', 'Antioch', 'Arcadia', 'Bakersfield', 'Barstow', 'Belmont', 'Berkeley', 'Beverly Hills', 'Brea', 'Buena Park', 'Burbank', 'Calexico', 'Calistoga', 'Carlsbad', 'Carmel', 'Chico', 'Chula Vista', 'Claremont', 'Compton', 'Concord', 'Corona', 'Coronado', 'Costa Mesa', 'Culver City', 'Daly City', 'Davis', 'Downey', 'El Centro', 'El Cerrito', 'El Monte', 'Escondido', 'Eureka', 'Fairfield', 'Fontana', 'Fremont', 'Fresno', 'Fullerton', 'Garden Grove', 'Glendale', 'Hayward', 'Hollywood', 'Huntington Beach', 'Indio', 'Inglewood', 'Irvine', 'La Habra', 'Laguna Beach', 'Lancaster', 'Livermore', 'Lodi', 'Lompoc', 'Long Beach', 'Los Angeles', 'Malibu', 'Martinez', 'Marysville', 'Menlo Park', 'Merced', 'Modesto', 'Monterey', 'Mountain View', 'Napa', 'Needles', 'Newport Beach', 'Norwalk', 'Novato', 'Oakland', 'Oceanside', 'Ojai', 'Ontario', 'Orange', 'Oroville', 'Oxnard', 'Pacific Grove', 'Palm Springs', 'Palmdale', 'Palo Alto', 'Pasadena', 'Petaluma', 'Pomona', 'Port Hueneme', 'Rancho Cucamonga', 'Red Bluff', 'Redding', 'Redlands', 'Redondo Beach', 'Redwood City', 'Richmond', 'Riverside', 'Roseville', 'Sacramento', 'Salinas', 'San Bernardino', 'San Clemente', 'San Diego', 'San Fernando', 'San Francisco', 'San Gabriel', 'San Jose', 'San Juan Capistrano', 'San Leandro', 'San Luis Obispo', 'San Marino', 'San Mateo', 'San Pedro', 'San Rafael', 'San Simeon', 'Santa Ana', 'Santa Barbara', 'Santa Clara', 'Santa Clarita', 'Santa Cruz', 'Santa Monica', 'Santa Rosa', 'Sausalito', 'Simi Valley', 'Sonoma', 'South San Francisco', 'Stockton', 'Sunnyvale', 'Susanville', 'Thousand Oaks', 'Torrance', 'Turlock', 'Ukiah', 'Vallejo', 'Ventura', 'Victorville', 'Visalia', 'Walnut Creek', 'Watts', 'West Covina', 'Whittier', 'Woodland', 'Yorba Linda', 'Yuba City']
SELECT_CO_CITIES = ['Alamosa', 'Aspen', 'Aurora', 'Boulder', 'Breckenridge', 'Brighton', 'Canon City', 'Central City', 'Climax', 'Colorado Springs', 'Cortez', 'Cripple Creek', 'Denver', 'Durango', 'Englewood', 'Estes Park', 'Fort Collins', 'Fort Morgan', 'Georgetown', 'Glenwood Springs', 'Golden', 'Grand Junction', 'Greeley', 'Gunnison', 'La Junta', 'Leadville', 'Littleton', 'Longmont', 'Loveland', 'Montrose', 'Ouray', 'Pagosa Springs', 'Pueblo', 'Silverton', 'Steamboat Springs', 'Sterling', 'Telluride', 'Trinidad', 'Vail', 'Walsenburg', 'Westminster']
SELECT_NY_CITIES = ['Amsterdam', 'Auburn', 'Babylon', 'Batavia', 'Beacon', 'Bedford', 'Binghamton', 'Bronx', 'Brooklyn', 'Buffalo', 'Chautauqua', 'Cheektowaga', 'Clinton', 'Cohoes', 'Coney Island', 'Cooperstown', 'Corning', 'Cortland', 'Crown Point', 'Dunkirk', 'East Aurora', 'East Hampton', 'Eastchester', 'Elmira', 'Flushing', 'Forest Hills', 'Fredonia', 'Garden City', 'Geneva', 'Glens Falls', 'Gloversville', 'Great Neck', 'Hammondsport', 'Harlem', 'Hempstead', 'Herkimer', 'Hudson', 'Huntington', 'Hyde Park', 'Ilion', 'Ithaca', 'Jamestown', 'Johnstown', 'Kingston', 'Lackawanna', 'Lake Placid', 'Levittown', 'Lockport', 'Mamaroneck', 'Manhattan', 'Massena', 'Middletown', 'Mineola', 'Mount Vernon', 'New Paltz', 'New Rochelle', 'New Windsor', 'New York City', 'Newburgh', 'Niagara Falls', 'North Hempstead', 'Nyack', 'Ogdensburg', 'Olean', 'Oneida', 'Oneonta', 'Ossining', 'Oswego', 'Oyster Bay', 'Palmyra', 'Peekskill', 'Plattsburgh', 'Port Washington', 'Potsdam', 'Poughkeepsie', 'Queens', 'Rensselaer', 'Rochester', 'Rome', 'Rotterdam', 'Rye', 'Sag Harbor', 'Saranac Lake', 'Saratoga Springs', 'Scarsdale', 'Schenectady', 'Seneca Falls', 'Southampton', 'Staten Island', 'Stony Brook', 'Stony Point', 'Syracuse', 'Tarrytown', 'Ticonderoga', 'Tonawanda', 'Troy', 'Utica', 'Watertown', 'Watervliet', 'Watkins Glen', 'West Seneca', 'White Plains', 'Woodstock', 'Yonkers']

zUS_STATES_CITIES = {
    'New York City': ['Manhattan', 'Queens', 'Brookyln', 'Bronx', 'Staten Island'],#.sort,        
    # 'Massachusetts': ['Boston'].sort,
    # #'Nevada': ['Reno', 'Las Vegas', 'Carson City'].sort,
    # 'New York': ['New York City'].sort,
    # # 'New Jersey': ['New Jersey'].sort,
    # 'Oregon': ['Portland', 'Bend'].sort,
    # 'Washington': ['Seattle'].sort,
    # 'Israel': ['Tel Aviv']
  }

CITY_IMAGES = {
  'new-york-city': 'https://images.unsplash.com/photo-1587162146766-e06b1189b907?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2850&q=80',
  'boston': 'https://images.unsplash.com/photo-1572128023846-8cf5791a1299?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2978&q=80',
  'los-angeles': 'https://images.unsplash.com/photo-1597982087634-9884f03198ce?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2865&q=80',
  'tel-aviv': 'https://static.timesofisrael.com/www/uploads/2020/02/Untitled-4-6.jpg'
}.hwia

PRODUCT_TYPES = {
    'Flower': ['Edibles', 'Gummies', 'Chocolates', 'Brownies', 'Mints'].sort,
    'Prerolls': ['Edibles', 'Gummies', 'Chocolates', 'Brownies', 'Mints'].sort,
    'Vapes': ['Flower', 'Alaska', 'Purple Haze', 'Lemon Kush'].sort,    
    'Edibles': ['Edibles', 'Gummies', 'Chocolates', 'Brownies', 'Mints'].sort,    
    'Tinctures': ['Tinctures', 'CBD Oil', 'THC Oil'].sort,
    'Other': ['Other'].sort,
  }


COUNTRIES = [
  {val: 'usa',    label: 'United States'},
  {val: 'uk',     label: 'United Kingdom'},
  {val: 'ar',     label: 'Argentina'},
  {val: 'austria',      label: 'Austria'},
  {val: 'australia',    label: 'Australia'},
  {val: 'be',    label: 'Belgium'},
  {val: 'br',    label: 'Brazil'},
  {val: 'ca',    label: 'Canada'},
  {val: 'ch',    label: 'Chile'},
  {val: 'co',    label: 'Colombia'},
  {val: 'cr',    label: 'Costa Rica'},
  {val: 'croatia',    label: 'Croatia'},
  {val: 'cz',    label: 'Czech Republic'},
  {val: 'dn',    label: 'Denmark'},
  {val: 'fi',    label: 'Finland'},
  {val: 'fr',    label: 'France'},
  {val: 'de',    label: 'Germany'},
  {val: 'gu',    label: 'Guatemala'},
  {val: 'hu',    label: 'Hungary'},
  {val: 'ir',    label: 'Ireland'},
  {val: 'is', label: 'Israel'},
  {val: 'it',    label: 'Italy'},
  {val: 'la',    label: 'Latvia'},
  {val: 'li',    label: 'Lithuania'},
  {val: 'me',    label: 'Mexico'},
  {val: 'ne',    label: 'Netherlands'},
  {val: 'nz',    label: 'New Zealand'},
  {val: 'no',    label: 'Norway'},
  {val: 'pa',    label: 'Panama'},
  {val: 'pe',    label: 'Peru'},
  {val: 'po',    label: 'Poland'},   
  {val: 'portugal',    label: 'Portugal'},   
  {val: 'slovakia',    label: 'Slovakia'},   
  {val: 'slovenia',    label: 'Slovenia'},   
  {val: 'es',    label: 'Spain'},   
  {val: 'sw',    label: 'Sweden'},   
  {val: 'switzerland',    label: 'Switzerland'},   
  {val: 'uk',    label: 'United Kingdom'},   
  {val: 'ur',    label: 'Uruguay'},   
  {val: 've',    label: 'Venezuela'},   
]

LANGUAGES = [  
  {val: 'en', label: 'English'},
  {val: 'es', label: 'Spanish'},
  {val: 'ru', label: 'Russian'},  
  {val: 'he', label: 'Hebrew' }  
]

SEARCH_OPTS = ['test', 'sativa', 'indica', 'joints', 'brownies', 'bongs', 'Kush', 'Afghan Kush', 'Hindu Kush', 'Green Kush', 'Purple Kush', 'Blueberry Kush', 'Golden Jamaican Kush', 'Diesel Haze'] 

STRAINS = [
  {val: 'Sativa', label: 'English'},
  {val: 'es', label: 'Spanish'},
  {val: 'ru', label: 'Russian'},  
  {val: 'he', label: 'Hebrew' }  
]

ITEM_TYPES = [
  {val: 'en', label: 'English'},
  {val: 'es', label: 'Spanish'},
  {val: 'ru', label: 'Russian'},  
  {val: 'he', label: 'Hebrew' }  
]

SOCIAL_NETWORKS = [
  'website', 'twitter', 'instagram', 'facebook', 'linkedin', 'github'
]

#CAST_TYPES_PLURAL = ['Bootcamps', 'Lectures', 'Classes', 'Courses', 'Webinars', 'Shows', 'Social Events', 'Team-Building Events']

# CAST_TYPES_PLURAL = ['Coding', 'Cybersecurity', 'Data Science', 'Online Marketing', 'Product Management', 'UI/UX', 'Graphic Design']

#CAST_TYPES_PLURAL = ['Full-Stack', 'Web Development', 'React', 'SQL', 'Cybersecurity', 'Data Science', 'SEO', 'JavaScript', 'CSS', 'Ruby', 'Python', 'Mind & Body', 'Git', 'MongoDB', 'NodeJS', 'Wordpress', 'Interviewing', 'Job Searching']

#CAST_TYPES_PLURAL = ['Tech', 'Fitness', 'Languages', 'Marketing', 'Photography', 'Dance', 'React', 'SQL', 'Cybersecurity', 'Art', 'Data Science', 'SEO', 'JavaScript', 'CSS', 'Python', 'Photoshop', 'Git', 'MongoDB', 'NodeJS'] #, 'Wordpress', 'Interviewing', 'Job Searching']

#CAST_TYPES_PLURAL = ['Programming', 'Fitness', 'Languages', 'Mental Well-Being', 'Marketing', 'Photography', 'Dance', 'React', 'SQL', 'Cybersecurity', 'Data Science', 'SEO', 'JavaScript', 'CSS', 'Python', 'Photoshop'] #, 'Wordpress', 'Interviewing', 'Job Searching']

# CAST_TYPES_PLURAL = ['Languages', 'Fitness', 'Coding', 'Graphic Design', 'Mental Well-Being', 'Online Marketing', 'Photography', 'Data Science', 'Religion', 'Spirituality', 'SQL', 'Photoshop']#.sort

CAST_TYPES_PLURAL = ['Languages', 'Fitness', 'Tech', 'Business', 'Mental Well-Being', 'Lifestyle']#.sort

FORUM_THREAD = 'Discussion Thread'
CAST_TYPES_SINGLE = ['Class', 'Course', 'Lecture', 'Webinar']

REFERRAL_PCT    = 10
REFERRAL_MONTHS = 6


ORDER_STATUSES = ['new', 'seen by a human', 'on its way', 'delivered', 'received', 'reviewed']

$last_names   = ['SMITH', 'JOHNSON', 'MILLER', 'BROWN', 'JONES', 'WILLIAMS', 'DAVIS', 'ANDERSON', 'WILSON', 'MARTIN', 'TAYLOR', 'MOORE', 'THOMPSON', 'WHITE', 'CLARK', 'THOMAS', 'HALL', 'BAKER', 'NELSON', 'ALLEN', 'YOUNG', 'HARRIS', 'KING', 'ADAMS', 'LEWIS', 'WALKER', 'WRIGHT', 'ROBERTS', 'CAMPBELL', 'JACKSON', 'PHILLIPS', 'HILL', 'SCOTT', 'ROBINSON', 'MURPHY', 'COOK', 'GREEN', 'LEE', 'EVANS', 'PETERSON', 'MORRIS', 'COLLINS', 'MITCHELL', 'PARKER', 'ROGERS', 'STEWART', 'TURNER', 'WOOD', 'CARTER', 'MORGAN', 'COX', 'KELLY', 'EDWARDS', 'BAILEY', 'WARD', 'REED', 'MYERS', 'SULLIVAN', 'COOPER', 'BENNETT', 'HUGHES', 'LONG', 'FISHER', 'PRICE', 'RUSSELL', 'HOWARD', 'GRAY', 'BELL', 'WATSON', 'REYNOLDS', 'FOSTER', 'ROSS', 'OLSON', 'RICHARDSON', 'SNYDER', 'POWELL', 'STEVENS', 'BROOKS', 'PERRY', 'WEST', 'COLE', 'WAGNER', 'MEYER', 'KENNEDY', 'BARNES', 'HAMILTON', 'GRAHAM', 'SCHMIDT', 'SANDERS', 'MCDONALD', 'PATTERSON', 'MURRAY', 'GIBSON', 'WALLACE', 'BUTLER', 'HAYES', 'BURNS', 'ELLIS', 'FOX', 'STONE', 'HENDERSON', 'WELLS', 'RYAN', 'JENKINS', 'HANSEN', 'WEBB', 'JAMES', 'JORDAN', 'GRIFFIN', 'HOFFMAN', 'HARRISON', 'ROSE', 'SIMMONS', 'MARSHALL', 'JOHNSTON', 'OWENS', 'NICHOLS', 'WEAVER', 'KELLEY', 'MILLS', 'ALEXANDER', 'TUCKER', 'PALMER', 'RICE', 'LARSON', 'SIMPSON', 'SHAW', 'CARLSON', 'HUNT', 'BLACK', 'FORD', 'PETERS', 'ARNOLD', 'ROBERTSON', 'PIERCE', 'DUNN', 'CRAWFORD', 'BRYANT', 'CARPENTER', 'PORTER', 'CARROLL', 'ELLIOTT', 'FREEMAN', 'MASON', 'FERGUSON', 'OBRIEN', 'HART', 'COLEMAN', 'WARREN', 'JENSEN', 'GARDNER', 'HICKS', 'STEPHENS', 'HENRY', 'GORDON', 'BURKE', 'WEBER', 'DUNCAN', 'RICHARDS', 'WOODS', 'HANSON', 'LANE', 'PAYNE', 'CHAPMAN', 'SCHULTZ', 'WHEELER', 'RAY', 'CUNNINGHAM', 'WALSH', 'KNIGHT', 'BISHOP', 'BOYD', 'ARMSTRONG', 'SCHNEIDER', 'HUNTER', 'SPENCER', 'LYNCH', 'MORRISON', 'RILEY', 'ANDREWS', 'BERRY', 'BRADLEY', 'PERKINS', 'HUDSON', 'WELCH', 'GILBERT', 'LAWRENCE', 'HOWELL', 'WALTERS', 'HOLMES', 'WILLIAMSON', 'JACOBS', 'DAVIDSON', 'LAWSON', 'KELLER', 'MAY', 'DIXON', 'DAY', 'CARR', 'DEAN', 'GEORGE', 'FOWLER', 'BECK', 'NEWMAN', 'HAWKINS', 'BECKER', 'BOWMAN', 'GREENE', 'HARPER', 'BREWER', 'MATTHEWS', 'POWERS', 'SCHWARTZ', 'WILLIS', 'FULLER', 'BARRETT', 'DANIELS', 'HARVEY', 'COHEN', 'CURTIS', 'WATKINS', 'HOLLAND', 'MONTGOMERY', 'AUSTIN', 'GRANT', 'GARRETT', 'ERICKSON', 'LAMBERT', 'KLEIN', 'ZIMMERMAN', 'WOLFE', 'MCCARTHY', 'STANLEY', 'BARKER', 'BURTON', 'OLIVER', 'LITTLE', 'LUCAS', 'LEONARD', 'PEARSON', 'MCCOY', 'CRAIG', 'BARNETT', 'BATES', 'GREGORY', 'HOPKINS', 'OCONNOR', 'WARNER', 'SWANSON', 'NORRIS', 'HALE', 'ROBBINS', 'HOLT', 'RHODES', 'CHRISTENSEN', 'STEELE', 'MCDANIEL', 'BENSON', 'MANN', 'SHELTON', 'LOWE', 'HIGGINS', 'FISCHER', 'DOYLE', 'GRIFFITH', 'REID', 'FRANKLIN', 'QUINN', 'FLEMING', 'SUTTON', 'BALL', 'MCLAUGHLIN', 'WOLF', 'SHARP', 'GALLAGHER', 'BOWEN', 'FITZGERALD', 'GROSS', 'SCHROEDER', 'POTTER', 'CALDWELL', 'JENNINGS', 'REEVES', 'ADKINS', 'BRADY', 'LYONS', 'MULLINS', 'WADE', 'BALDWIN', 'VAUGHN', 'MUELLER', 'CHAMBERS', 'PAGE', 'PARKS', 'BLAIR', 'FIELDS', 'PARSONS', 'FLETCHER', 'WATTS', 'SIMS', 'RAMSEY', 'HARTMAN', 'KRAMER', 'BUSH', 'HORTON', 'BAUER', 'BARBER', 'SHERMAN', 'DOUGLAS', 'GRAVES', 'CHANDLER', 'CROSS', 'BARTON', 'HARMON', 'CUMMINGS', 'FLYNN', 'TODD', 'MCKINNEY', 'GOODMAN', 'TERRY', 'CASEY', 'FRANK', 'DAWSON', 'OWEN', 'NEWTON', 'THORNTON', 'MORAN', 'SHAFFER', 'MCCORMICK', 'BURGESS', 'MCGUIRE', 'GOODWIN', 'HESS', 'NORTON', 'FRENCH', 'OSBORNE', 'MANNING', 'BOWERS', 'ROTH', 'HARRINGTON', 'OLSEN', 'ROWE', 'BYRD', 'NEAL', 'HAMMOND', 'WEISS', 'FARMER', 'WISE', 'SPARKS', 'GARNER', 'WEBSTER', 'PAUL', 'RODGERS', 'MOSS', 'GARCIA', 'PETERSEN', 'SIMON', 'HOOVER', 'HODGES', 'HAYNES', 'FRAZIER', 'MILES', 'DECKER', 'MARSH', 'MEYERS', 'STRICKLAND', 'BLAKE', 'DENNIS', 'LAMB', 'BUCHANAN', 'HOGAN', 'BROCK', 'YATES', 'COCHRAN', 'LARSEN', 'CONNER', 'LANG', 'DANIEL', 'HUBBARD', 'MAXWELL', 'WATERS', 'CANNON', 'PATTON', 'REESE', 'HARDY', 'GILL', 'MALONE', 'DRAKE', 'PRATT', 'STEVENSON', 'SHORT', 'WALL', 'FOLEY', 'SWEENEY', 'TOWNSEND', 'WILCOX', 'WILKINSON', 'HENSLEY', 'ABBOTT', 'FARRELL', 'SHEPHERD', 'SAUNDERS', 'MARTINEZ', 'NORMAN', 'MCGEE', 'BRYAN', 'MCBRIDE', 'BERG', 'COMBS', 'LOVE', 'BRENNAN', 'CAIN', 'CLINE', 'HUFFMAN', 'BALLARD', 'COBB', 'KIRBY', 'ONEILL', 'FRANCIS', 'KOCH', 'LLOYD', 'RUSSO', 'CAREY', 'CALLAHAN', 'MOODY', 'MORROW', 'UNDERWOOD', 'YORK', 'POPE', 'BOYER', 'HUFF', 'MORTON', 'SUMMERS', 'BRIGGS', 'HORN', 'KANE', 'WALTON', 'PHELPS', 'RODRIGUEZ', 'DALTON', 'PATRICK', 'CONLEY', 'KIRK', 'CURRY', 'HANCOCK', 'FLOYD', 'MACDONALD', 'YODER', 'LOGAN', 'LINDSEY', 'NICHOLSON', 'JACOBSON', 'GARRISON', 'WALTER', 'KLINE', 'ALLISON', 'SKINNER', 'SILVA', 'CHASE', 'INGRAM', 'GIBBS', 'BURNETT', 'ATKINSON', 'DILLON', 'VINCENT', 'HEATH', 'BRUCE', 'CARSON', 'STEIN', 'CLARKE', 'BOOTH', 'GREER', 'RICH', 'ODONNELL', 'HINES', 'HOOD', 'BANKS', 'POOLE', 'BERGER', 'CAMERON', 'BLANKENSHIP', 'MCCLURE', 'MASSEY', 'EATON', 'BARRY', 'RANDALL', 'DAVENPORT', 'TYLER', 'PARRISH', 'MELTON', 'DYER', 'WHITAKER', 'STOUT', 'BOND', 'ROY', 'SNOW', 'WYATT', 'SAWYER', 'KNAPP', 'BAXTER', 'HENSON', 'NOLAN', 'BARTLETT', 'SCHAEFER', 'MARKS', 'STARK', 'NIELSEN', 'CLAYTON', 'GATES', 'SEXTON', 'TATE', 'TANNER', 'BASS', 'MCKEE', 'MATHEWS', 'HERMAN', 'SHIELDS', 'STEPHENSON', 'REILLY', 'HURST', 'JOHNS', 'VANCE', 'RICHARD', 'HOBBS', 'BUCK', 'KERR', 'GRIMES', 'BROWNING', 'KEITH', 'COLLIER', 'MCKENZIE', 'MORSE', 'CONRAD', 'HUTCHINSON', 'HOWE', 'SAVAGE', 'HAMPTON', 'BOYLE', 'DONOVAN', 'HEBERT', 'MAYER', 'COPELAND', 'NASH', 'BRIDGES', 'STAFFORD', 'GOLDEN', 'KENT', 'MCMAHON', 'ROACH', 'WILKINS', 'MAHONEY', 'PECK', 'HULL', 'LOPEZ', 'DOUGHERTY', 'BEARD', 'CONWAY', 'CASE', 'LEACH', 'BARR', 'LEBLANC', 'PENNINGTON', 'HODGE', 'HURLEY', 'ORR', 'FROST', 'STOKES', 'CHRISTIAN', 'GENTRY', 'KRUEGER', 'MEADOWS', 'FRIEDMAN', 'MCCONNELL', 'HUBER', 'WINTERS', 'WEEKS', 'GLOVER', 'HAHN', 'HUMPHREY', 'DUFFY', 'ATKINS', 'PITTMAN', 'MONROE', 'BRADFORD', 'FRY', 'SHANNON', 'BENDER', 'BUCKLEY', 'SLOAN', 'GILLESPIE', 'MOYER', 'PRESTON', 'MERRITT', 'FITZPATRICK', 'MCINTYRE', 'OCONNELL', 'MCDOWELL', 'SCHMITT', 'NOVAK', 'LESTER', 'RASMUSSEN', 'BRANDT', 'MICHAEL', 'CRANE', 'BLACKBURN', 'HOLLOWAY', 'BLEVINS', 'MATHIS', 'MCCULLOUGH', 'GOULD', 'ENGLISH', 'HARRELL', 'KAUFMAN', 'BOONE', 'DICKERSON', 'KRAUSE', 'HARDIN', 'WERNER', 'FREDERICK', 'ANTHONY', 'WOODWARD', 'AYERS', 'KEMP', 'HAAS', 'BRADSHAW', 'SELLERS', 'HENDRICKS', 'MULLEN', 'MCGRATH', 'MCFARLAND', 'BENTLEY', 'NOBLE', 'GLASS', 'CHURCH', 'IRWIN', 'MCCARTY', 'LANDRY', 'CLEMENTS', 'HERNANDEZ', 'LYNN', 'GILMORE', 'WILEY', 'BLANCHARD', 'ANDERSEN', 'DURHAM', 'PITTS', 'PRUITT', 'LEVINE', 'COFFEY', 'BEASLEY', 'BAIRD', 'MACK', 'FARLEY', 'DAUGHERTY', 'ESTES', 'MAYNARD', 'MCCANN', 'CANTRELL', 'VAUGHAN', 'RAYMOND', 'WHITEHEAD', 'HARDING', 'FREY', 'BLACKWELL', 'GOOD', 'BRAUN', 'HATFIELD', 'GLENN', 'HOUSE', 'FRITZ', 'PRINCE', 'PACE', 'WILKERSON', 'HICKMAN', 'HANNA', 'DODSON', 'FRYE', 'COMPTON', 'RITTER', 'ONEAL', 'BEAN', 'KAISER', 'POTTS', 'HAYS', 'LUTZ', 'SHEA', 'ROWLAND', 'LIVINGSTON', 'BIRD', 'STUART', 'MOONEY', 'FLOWERS', 'SHEPARD', 'MCKAY', 'HALEY', 'RIGGS', 'JOYCE', 'LEHMAN', 'STRONG', 'MADDEN', 'DUNLAP', 'WHITNEY', 'HAYDEN', 'OSBORN', 'SMALL', 'JARVIS', 'MOON', 'DONNELLY', 'HOUSTON', 'KATZ', 'DUKE', 'MCINTOSH', 'SNIDER', 'DAVIES', 'COSTA', 'RIDDLE', 'LOWERY', 'DONAHUE', 'VOGEL', 'LEVY', 'STANTON', 'MCCLAIN', 'KUHN', 'GOLDSTEIN', 'WITT', 'SHOEMAKER', 'MERRILL', 'PEREZ', 'WINTER', 'HANEY', 'GOLDBERG', 'ODELL', 'FAULKNER', 'MCLEAN', 'RUSH', 'BRAY', 'COSTELLO', 'DOWNS', 'ROBERSON', 'BURCH', 'GORMAN', 'CARVER', 'LANGE', 'GONZALEZ', 'WORKMAN', 'JOSEPH', 'MALONEY', 'ELLISON', 'GUTHRIE', 'KAPLAN', 'MERCER', 'GOFF', 'DALY', 'CRAMER', 'MCCALL', 'MOSER', 'KNOX', 'MIDDLETON', 'CROSBY', 'CARNEY', 'RICHTER', 'WOODARD', 'SPEARS', 'HOOPER', 'HERRING', 'SANFORD', 'CROWLEY', 'KESSLER', 'WALLS', 'BYRNE', 'CONNOLLY', 'MCDERMOTT', 'EVERETT', 'WIGGINS', 'BULLOCK', 'HENDRICKSON', 'CHILDERS', 'HELMS', 'MCMILLAN', 'FINK', 'FINLEY', 'ASHLEY', 'MCCABE', 'PEARCE', 'HARTLEY', 'ARCHER', 'HENDRIX', 'BEACH', 'AVERY', 'LANCASTER', 'BEST', 'JUSTICE', 'HICKEY', 'WELSH', 'DICKSON', 'TRACY', 'KINNEY', 'PUGH', 'HOLDEN', 'MARINO', 'SOLOMON', 'MCPHERSON', 'FLANAGAN', 'CALHOUN', 'HORNE', 'DELANEY', 'SPRINGER', 'SEARS', 'HAINES', 'BENTON', 'RICHMOND', 'RITCHIE', 'DONALDSON', 'GILES', 'COWAN', 'HESTER', 'DOLAN', 'KERN', 'CROWE', 'ENGLAND', 'SPENCE', 'TUTTLE', 'VALENTINE', 'PETTY', 'DOHERTY', 'BYERS', 'EWING', 'EMERSON', 'COOLEY', 'HOLCOMB', 'KENDALL', 'LAKE', 'DODD', 'SLATER', 'SORENSEN', 'COOKE', 'CLAY', 'GUSTAFSON', 'LYON', 'NEWELL', 'SANCHEZ', 'CAMP', 'CRAFT', 'BARLOW', 'SWEET', 'TRAVIS', 'MADDOX', 'DAVID', 'SHEEHAN', 'HYDE', 'PUCKETT', 'BOGGS', 'WALLER', 'ONEIL', 'DWYER', 'PROCTOR', 'ALBERT', 'SINGLETON', 'MCNAMARA', 'SHEPPARD', 'MCKENNA', 'CHAMBERLAIN', 'GIBBONS', 'BARRON', 'FRANKS', 'HASTINGS', 'HOLDER', 'FERRELL', 'CRABTREE', 'MCGOWAN', 'BERNARD', 'PARK', 'DAILEY', 'HEWITT', 'SUTHERLAND', 'KIDD', 'PIKE', 'CASSIDY', 'SWARTZ', 'SHAFER', 'GALLOWAY', 'OTT', 'ROMANO', 'KENNEY', 'BOLTON', 'HELLER', 'FARRIS', 'ROSENBERG', 'FINCH', 'GAY', 'STARR', 'HOPPER', 'BOWLING', 'WARE', 'ODOM', 'MULLER', 'MEIER', 'ROLLINS', 'DICKINSON', 'FORBES', 'DEMPSEY', 'SHAPIRO', 'DUDLEY', 'ROSSI', 'CHANEY', 'PIERSON', 'LINDSAY', 'KIRKPATRICK', 'SCHUMACHER', 'DENTON', 'MCGINNIS', 'PATE', 'CURRAN', 'SARGENT', 'ZIEGLER', 'NIXON', 'ACKERMAN', 'CONNOR', 'RATLIFF', 'SINGER', 'BRIGHT', 'DOWNEY', 'GLEASON', 'DYE', 'SAMPSON', 'COUCH', 'FULTON', 'COFFMAN', 'DALE', 'ELDER', 'FUNK', 'STERN', 'WORLEY', 'COURTNEY', 'RUTHERFORD', 'RANDOLPH', 'SHIRLEY', 'CASH', 'MCALLISTER', 'HAMM', 'SCHAFER', 'FISH', 'DOWNING', 'BELCHER', 'BRUNO', 'KNOWLES', 'BRITT', 'SCHULZ', 'EMERY', 'ALBRIGHT', 'HELTON', 'HOLMAN', 'ROE', 'KEY', 'HILTON', 'HATCH', 'LUND', 'DEWITT', 'BACON', 'RANKIN', 'LANGLEY', 'BLOOM', 'KURTZ', 'PADGETT', 'MAYS', 'FIELD', 'AKERS', 'DOTSON', 'FELDMAN', 'GOLDMAN', 'SCHMITZ', 'WHALEN', 'GODFREY', 'MAYO', 'WEBBER', 'POLLARD', 'HAGEN', 'TIPTON', 'ELKINS', 'CROUCH', 'LOCKE', 'CONKLIN', 'WILLS', 'DRISCOLL', 'POST', 'SIMONS', 'THOMSON', 'SWENSON', 'STEINER', 'ARTHUR', 'STOVER', 'ROSEN', 'CHRISTOPHER', 'HEAD', 'SANTOS', 'HORNER', 'HOLBROOK', 'MEEKS', 'KIMBALL', 'EGAN', 'GREGG', 'NEFF', 'WOODRUFF', 'HUTCHISON', 'MAHER', 'MACKEY', 'MCLEOD', 'ESPOSITO', 'STAHL', 'BRITTON', 'MASTERS', 'PRITCHARD', 'MOSES', 'CONNELLY', 'ROBISON', 'YEAGER', 'CORBETT', 'LOWRY', 'LUDWIG', 'SPRAGUE', 'LAW', 'INMAN', 'CHERRY', 'SIEGEL', 'GOSS', 'MCMANUS', 'TOMLINSON', 'WILDER', 'CROW', 'GROVES', 'LORD', 'OTTO', 'GRIMM', 'BABCOCK', 'OLEARY', 'BEATTY', 'WINKLER', 'PAINTER', 'ENGEL', 'METCALF', 'KOENIG', 'CONNELL', 'MCDONOUGH', 'SEYMOUR', 'JEWELL', 'SELF', 'BURT', 'HAMMER', 'RUBIN', 'PICKETT', 'CLEVELAND', 'SANDERSON', 'STRATTON', 'HINKLE', 'KRAFT', 'BOWER', 'DEVINE', 'HUTCHINS', 'MORIN', 'MCCLELLAN', 'MEREDITH', 'DODGE', 'KIRKLAND', 'BINGHAM', 'POLLOCK', 'SHARPE', 'WOOTEN', 'ELDRIDGE', 'GARLAND', 'MCCAULEY', 'REGAN', 'CLIFTON', 'WOLFF', 'NICHOLAS', 'MEAD', 'DOOLEY', 'KAY', 'HEALY', 'GROVE', 'MANLEY', 'BLANTON', 'MCKNIGHT', 'TOMPKINS', 'GREENBERG', 'BOYCE', 'FRASER', 'RUTLEDGE', 'BURRIS', 'GREENWOOD', 'GUNTER', 'BLOCK', 'SHERIDAN', 'CLIFFORD', 'CHARLES', 'COTE', 'GEIGER', 'LINK', 'QUICK', 'KAUFFMAN', 'HATCHER', 'SINCLAIR', 'ERWIN', 'HAND', 'ALFORD', 'SHEETS', 'TALLEY', 'CORBIN', 'DUBOIS', 'DAHL', 'GAGNON', 'DICK', 'MAURER', 'DUGAN', 'DICKEY', 'METZGER', 'CLEMENT', 'TORRES', 'GRACE', 'GUY', 'HOLLEY', 'MAYFIELD', 'CHILDRESS', 'MCELROY', 'ELMORE', 'TEAGUE', 'HAGER', 'TERRELL', 'HOYT', 'WHITLEY', 'BENJAMIN', 'WILLARD', 'CARUSO', 'STILES', 'GONZALES', 'SHERWOOD', 'BEAVER', 'LARKIN', 'GAMBLE', 'KRUSE', 'PURCELL', 'CAHILL', 'PHIPPS', 'TOTH', 'FERRIS', 'WALDEN', 'HOLLINGSWORTH', 'VOSS', 'COKER', 'CORNELL', 'BUTCHER', 'JORGENSEN', 'GAINES', 'MCFADDEN', 'MOSLEY', 'NIX', 'PIPER', 'BOWLES', 'ROOT', 'STROUD', 'REECE', 'HERRON', 'SWIFT', 'MESSER', 'OHARA', 'DUNHAM', 'WILHELM', 'METZ', 'MEADE', 'URBAN', 'SCHAFFER', 'DRAPER', 'HERBERT', 'AMES', 'DALEY', 'NOEL', 'POE', 'STINSON', 'THACKER', 'BIGGS', 'HOLLIS', 'FINN', 'PEDERSEN', 'BERGERON', 'RAMEY', 'BARNHART', 'BURGER', 'BOUCHER', 'FOREMAN', 'SIZEMORE', 'COYLE', 'GRADY', 'BILLINGS', 'ABRAMS', 'CULLEN', 'GODWIN', 'MCGILL', 'HINTON', 'PAULSON', 'CUMMINS', 'LESLIE', 'KOEHLER', 'MCNEIL', 'LOVELL', 'WOMACK', 'MINER', 'LEVIN', 'DIAMOND', 'YOST', 'WASHBURN', 'MILLIGAN', 'ALDRIDGE', 'KEENAN', 'SMART', 'ENGLE', 'WHALEY', 'JACOBSEN', 'PEACOCK', 'SILVER', 'WESTON', 'CONNORS', 'DORSEY', 'SWAN', 'CRONIN', 'CREWS', 'BARNARD']

OUR_TAGLINES = [
  'local cannabis brands.',
  'people who grow cannabis',
  'people who sell cannabis.',
  'the cannabis network.',
  'find your plug',
  'local cannabis delivery',
  'order cannabis online',
  'cannabis for you.',
  'the online cannabis marketplace'
]

ROOMS_LIST = [
    {label: 'brands', zip: 'no_zip'},    
    {label: 'dispensaries', zip: 'no_zip'},        
    {label: 'distributors', zip: 'no_zip'},    
    {label: 'cultivators', zip: 'no_zip'},
    {label: 'manufacturers', zip: 'no_zip'},    
    {label: 'investors', zip: 'no_zip'},    
    {label: 'lawyers', zip: 'no_zip'},    
    {label: 'startups', zip: 'no_zip'},    
  ]

ROOMS_LIST = [
  # {label: 'los angeles', zip: 'la'},
  # {label: 'new york city', zip: 'nyc'},
  # {label: 'tel aviv', zip: 'tlv'},

  # {label: 'california', zip: 'ca'},
  # {label: 'new york', zip: 'ny'},
  # {label: 'israel', zip: 'il'},
  # {label: 'delivery services',    zip: 'c'},
  # {label: 'education',    zip: 'edu'},
  # {label: 'staffing',  zip: 'a'},
  # {label: 'licensing', zip: 'law'},
  # {label: 'jobs',  zip: 'a'},
  # {label: 'brands',  zip: 'br'},
  # {label: 'financing', zip: 'b'},    
  # {label: 'videos', zip: 'leg'},
  # {label: 'lawyers', zip: 'lw'},
  # {label: 'investors',    zip: 'i'},
  # {label: 'startups',    zip: 'e'},
  {label: 'manhattan',    zip: 'manhattan'},
  {label: 'bronx',    zip: 'bronx'},
  {label: 'brooklyn',    zip: 'brooklyn'},
  {label: 'queens',    zip: 'queens'},
  {label: 'staten island',    zip: 'staten island'}

  # {label: 'california', zip: 'ca'},    
  # {label: 'washington', zip: 'wa'},    
  # {label: 'oregon', zip: 'or'},    
  # {label: 'colorado', zip: 'co'},    
  # {label: 'canada', zip: 'canada'},    
]