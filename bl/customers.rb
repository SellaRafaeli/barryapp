$customers = $mongo.collection('customers')

# a customer's user_id is the seller 
CUSTOMERS_FIELDS = ['user_id']

get '/customers/:id' do 
	customer = $customers.get(pr[:id])
	halt('unathorized') unless customer[:user_id] == cuid

	erb :'/customers/single_customer', default_layout.merge(locals: {customer: customer})
end

post '/customers' do 
	$customers.add({user_id: cuid, name: 'My Project'})
	flash.message = 'Added.'
	redirect back
end

post '/customers/:id' do 
	customer = $customers.get(pr[:id])
	halt('unauthorized') unless customer[:user_id] == cuid
	$customers.update_id(pr[:id], pr)
	flash.message = 'Updated.'
	redirect back
end

## todo: refactor all 'user_id' instances for customer code to 'seller_id'