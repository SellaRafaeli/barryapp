# dqp?
$stripe_customers         = $mongo.collection('stripe_customers')
$stripe_notifs            = $mongo.collection('stripe_notifs')
$subs = $subscriptions    = $mongo.collection('stripe_subscriptions')
$single_payments          = $mongo.collection('single_payments')

SUCCESS_STRIPE_NOTIFS_TYPES = ["checkout.session.completed", "customer.subscription.created"]

Stripe.api_key     = ENV['STRIPE_SECRET_KEY'] 

SECRET_STAGING_KEY = ENV['STRIPE_SECRET_STAGING_KEY'] 

post '/stripe_notif' do
	$stripe_notifs.add(pr)
	begin
		type    = pr[:type]
		user_id = pr[:data]['object']['client_reference_id']
		if user_id && type.in?(SUCCESS_STRIPE_NOTIFS_TYPES)
			$users.update_id(user_id, {paid: true, paid_at: Time.now}) rescue nil
		end
	rescue => e
		log_e(e)
	end
	
	{msg: 'ok'}	
end

post '/stripe/pay' do	
  data    = pr
  cast_id = pr[:cast_id]
  cast    = $casts.get(cast_id)
  is_trial= is_series(cast)
  amount  = cast[:cost_dollars].to_i * 100

  if cast_allows_variable_amount(cast) && pr[:variable_amount].to_i > 0
  	amount = pr[:variable_amount].to_i * 100 
  end

  begin
    if data['payment_method_id']
      # Create the PaymentIntent

      payload = {
        payment_method: data['payment_method_id'],
        amount: amount,
        metadata: {nowcast_seller_id: cast[:user_id], nowcast_cast_id: cast_id, nowcast_buyer_id: cuid},
        currency: 'usd',
        confirmation_method: 'manual',
        confirm: true,
      }

      opts = {}
    	opts[:api_key] = SECRET_STAGING_KEY if is_test_buy(cast)

			intent = Stripe::PaymentIntent.create(payload, opts)
    elsif data['payment_intent_id']
      intent = Stripe::PaymentIntent.confirm(data['payment_intent_id'])
      x=1
    end
  rescue Stripe::CardError => e
    # Display error on client
    return [200, { error: e.message }.to_json]
  end

  if (intent.status == 'succeeded') 
  	enroll_user(cuid, cast_id, {amount: amount, intent_id: intent.id, is_trial: is_trial, expires_at: Time.now + 1.week - 1.hour})
  	$single_payments.add({user_id: cuid, cast_id: cast_id, amount_cents: intent.amount, intent_id: intent.id})
  end

  return generate_response(intent)
end

def generate_response(intent)
  if intent.status == 'requires_action' &&
    intent.next_action.type == 'use_stripe_sdk' # Tell the client to handle the action
    [200,{requires_action: true, payment_intent_client_secret: intent.client_secret}.to_json ]
  elsif intent.status == 'succeeded'
    # The payment didn’t need any additional actions and is completed! Handle post-payment fulfillment
    [200, {success: true}.to_json]
  else # Invalid status
    return [500, { error: 'Invalid PaymentIntent status' }.to_json]
  end
end

# def prepare_single_payment(cast)
# 	data = cast
# 	data[:amount_cents] = data[:cost_dollars].to_i * 100
	
# 	intent = Stripe::PaymentIntent.create({
# 	  amount: data[:amount_cents].to_i,
# 	  currency: 'usd',
# 	  # Verify your integration in this guide by including this parameter
# 	  metadata: {integration_check: 'accept_a_payment', cast_id: cast[:_id], cast_title: cast[:title]},
# 	})

# 	return intent
# end


def stripe_pay_earnings(user_id, opts = {})
	cur_month = !opts[:last_month]
	time      = cur_month ? Date.today.at_beginning_of_month.to_datetime.to_i : Date.today.at_beginning_of_month.prev_month.to_datetime.to_i
	payments  = Stripe::Charge.list(limit: 10_000)

	x=1
end

######### BILLING #############

# https://stripe.com/docs/billing/subscriptions/cards

# plans:
# https://dashboard.stripe.com/test/subscriptions/products
# stripe-test
# 1 monthly: plan_HDwq4xzL6MY27A
# stripe-prod
# 1 monthly:  plan_HDvrZH7PrxAGUL
# 20 monthly: plan_HDvp8s3ryZMwPH
# 50 monthly: plan_HDvqgLl5YziIrj
post '/stripe/subscribe' do 		
	cast_id = pr[:cast_id]
	email   = cu[:email] #pr[:email]

	halt(401,{err: 'Missing cast_id'}) unless cast_id && (cast = $casts.get(cast_id))

	test_buy = is_test_buy(cast)
	
	opts = {}
	opts[:api_key] = SECRET_STAGING_KEY if test_buy

	#1. Create stripe customer
	customer = Stripe::Customer.create({
	  payment_method: pr[:payment_method],
	  email: email,	  
	  invoice_settings: {
	    default_payment_method: pr[:payment_method],
	  }}, opts
	)
	
	customer_obj = JSON.parse(customer.to_json).hwia
	$stripe_customers.add(customer_obj)

	#2. Create subscription
  # check plans
	plan_id             = ($prod && !test_buy) ? 'plan_HDvrZH7PrxAGUL' : 'plan_HDwq4xzL6MY27A'
	start_of_next_month = Date.today.at_beginning_of_month.next_month.to_datetime.to_i

	quantity            = cast[:cost_dollars].to_i

	if cast_allows_variable_amount(cast) && pr[:variable_amount].to_i > MIN_VARIABLE_AMOUNT
  	quantity = pr[:variable_amount].to_i
  end

  payload = {
		customer: customer.id,
	  items: [
      #plan is 1 USD a month, quantity raises it to actual amount
	  	{plan: plan_id, quantity: quantity}
	  ],

		# TODO start of next
	  #billing_cycle_anchor: start_of_next_month,
	  metadata: {nowcast_seller_id: cast[:user_id],
               nowcast_cast_id: cast_id,
               nowcast_buyer_id: cuid},
	  expand: ['latest_invoice.payment_intent']
	}
	
	subscription        = Stripe::Subscription.create(payload, opts)
	#3. Store subscription
	sub                 = JSON.parse(subscription.to_json).hwia	
	sub[:_id]           = sub[:id]
	sub[:user_id]       = cuid
	sub[:cast_id]       = cast_id
	sub[:cast_user_id]  = cast[:user_id]
	sub[:plan_amount]   = sub[:plan][:amount]

	added_sub = $subs.add(sub)

	paid_amount = added_sub[:latest_invoice][:amount_paid].to_i 
	enroll_user(cuid, cast_id, {sub_id: added_sub[:_id], amount: paid_amount})

	{msg: "ok"}
end

def cancel_stripe_sub(sub_id) 
	Stripe::Subscription.delete(sub_id)
	$subs.update_id(sub_id, {canceled_at: Time.now})
end

def stripe_sub_earnings(seller_id = nil, opts = {})
	puts "Loading stripe subscription earnings for #{seller_id}...".green

	cur_month = !opts[:last_month]
	time      = cur_month ? Date.today.at_beginning_of_month.to_datetime.to_i : Date.today.at_beginning_of_month.prev_month.to_datetime.to_i
	time      = opts[:time].to_i if opts[:time].present?
	subs      = Stripe::Subscription.list({limit: 1000, status: 'active', current_period_start: {gt: time}})
	
	seller_subs = subs[:data].select {|sub| !seller_id || (sub[:metadata] || {})[:nowcast_seller_id] == seller_id }

	seller_subs_clean = seller_subs.map {|sub| 
		data = {
			buyer_email: sub[:email],
			seller_id:   sub[:metadata][:nowcast_seller_id],
			buyer_id:    sub[:metadata][:nowcast_buyer_id],
			cast_id:     sub[:metadata][:nowcast_cast_id],
			created_at:  Time.at(sub[:created]),
			amount:      sub[:items][:data][0][:quantity] * 100
		}
	}

	{orig: seller_subs, clean: seller_subs_clean}
end

# dev: stripe_charges_for_seller("F82Lp")
def stripe_charges_for_seller(seller_id = nil, opts = {})
	puts "Loading stripe charges for #{seller_id}...".green

	cur_month = !opts[:last_month]
	time      = cur_month ? Date.today.at_beginning_of_month.to_datetime.to_i : Date.today.at_beginning_of_month.prev_month.to_datetime.to_i
	time      = opts[:time].to_i if opts[:time].present?
	list      = Stripe::Charge.list({limit: 1000, created: {gt: time}})
	charges   = []

	list.auto_paging_each do |charge|
		# checking that it's not a subscription and it's a valid
		charge_belongs_to_seller = (charge[:metadata] || {})[:nowcast_seller_id] == seller_id
		charge_belongs_to_a_cast = !(charge[:metadata] || {})[:nowcast_cast_id].nil?
		# checking that it's not a subscription (handled separtly at stripe_sub_earnings)
		is_a_valid_charge = (!seller_id || charge_belongs_to_seller) & charge_belongs_to_a_cast

		if is_a_valid_charge
			charges.push(charge)
		end
	end

	clean_charges = charges.to_a.map  { |charge|
		data = {
			seller_id:   charge[:metadata][:nowcast_seller_id],
			buyer_id:    charge[:metadata][:nowcast_buyer_id],
			cast_id:     charge[:metadata][:nowcast_cast_id],
			created_at:  Time.at(charge[:created]),
			amount:      charge[:amount]
		}
		data
	}

	{orig: charges, clean: clean_charges}
end

# all_seller_earnings("F82Lp")
def all_seller_earnings(seller_id = nil, opts = {})
	payments  		= stripe_charges_for_seller(seller_id, opts)[:clean]
	subscriptions 	= stripe_sub_earnings(seller_id, opts)[:clean]

	all       = payments + subscriptions
	{payments: payments, subs: subscriptions, all: all}
end

get '/my_earnings' do 
	user_id = cuid
	user_id = pr[:user_id] if pr[:user_id] && is_admin

	earnings = all_seller_earnings(user_id)

	erb :'stripe/my_earnings', default_layout.merge(locals: {user_id: user_id}) 
end

# get '/donation_success' do
# 	flash.message="Great, thanks!"
# 	redirect '/'
# end

# get '/donation_failure' do
# 	flash.message="Something went wrong with your donation"
# 	redirect '/'
# end