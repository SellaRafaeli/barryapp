# curl -i -H "Accept:application/json" -H "Content-Type:application/json" -H "Authorization: Bearer bb63ab66d6c07d3462ecbe503760fedaa190ec949c7f397131ab471995bc6dafN" -XPOST "https://gorest.co.in/public/v1/users" -d '{"name":"Tenali Ramakrishna", "gender":"male", "email":"tenali.ramakrishna@15ce.com", "status":"active"}'

# fuzz the create user call 
# def http_post(route, data = {}, headers = {})

route  = 'https://gorest.co.in/public/v1/users'
headers = {Authorization: 'Bearer bb63ab66d6c07d3462ecbe503760fedaa190ec949c7f397131ab471995bc6dafN'}
body   = {"name":"Tenali Ramakrishna", "gender":"male", "email": Faker::Internet.email, "status":"active"}

# http_post(route,body,headers)
def make_calls
	10.times {
		body    = fuzz_body
		headers = fuzz_headers
		route   = 'https://gorest.co.in/public/v1/users'
		
		
		Thread.new {
			res = http_post(route,body,headers)
			puts "----------"
			puts "body and headers are #{body}, #{headers}"
			puts "res: #{res}"
			puts "----------"
		}
	}
end

def random_val
	random_int    = rand(100000)
	random_string = Faker::Name.name * rand(100)
	random_obj    = {string: random_string, int: random_int}
	[random_int,random_string,random_obj].sample
end

def fuzz_body
	mail = Faker::Internet.email
	body   = {"name":"Tenali Ramakrishna", "gender":"male", "email": mail, "status":"active"}
	body.keys.each do |key|
		body[key] = random_val
	end
	body
end

def fuzz_headers
	headers = {Authorization: 'Bearer bb63ab66d6c07d3462ecbe503760fedaa190ec949c7f397131ab471995bc6dafN'}
	if (rand > 0.5) 
	#	headers.delete(:Authorization)
	end
	if (rand >0.5) 
		#headers[:Authorization] = guid
	end
	if (rand >0.5) 
	#	headers[guid] = guid
	end

	headers 
end

def fuzz_all
	body    = fuzz_body
	headers = fuzz_headers
end


# 