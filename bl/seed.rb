def build_phone_num_area_code(state)
	return ['212', '845', '718', '646', '914', '917', '929'].sample if state.downcase == 'ny'
	return ['209', '707', '415', '510', '949','805','916'].sample if state.downcase == 'ca'	
	return ['970','720','719'].sample if state.downcase == 'co'	
	return rand(900).to_i+100
end

def build_fake_desc
	''
end

def build_fake_img

end


def build_single_fake_brand(state, city)
	type   = ['cannabis', 'weed', 'bud', 'ganja', 'med', 'bros', 'medical', 'relief', 'recreational', 'products', 'green', 'haze', 'fam', 'gringos']	
	name   = $last_names.sample.capitalize
	handle = name+' '+type.sample.capitalize
	domain = ['gmail',name.to_s.downcase,'aol','yahoo']
	email  = name + rand(100).to_s + '@' + domain.sample + '.com'
	res = {
		_id: city.to_s+rand.to_s,
		name: name + ' ' +type.sample.capitalize,
		email: email,
		seed_brand: true,
		handle: handle,#.gsub(' ','_').dasherize,
		desc: build_fake_desc,
		contact: build_phone_num_area_code(state)+'-'+(rand(900)+100).to_s+'-'+(rand(9999)+1000).to_s,
		state: state,	
		city: city,
		img: build_fake_img,
		type: 'seller'
		
	}

	$users.add(res)
end

def build_fake_brands(state, city)
	# $users.delete_many(seed_brand: true)
	5.times { build_single_fake_brand(state, city) }
	x=1
end

def generate_products_for_seed_user(user)
	faker = Faker::Cannabis
	title = "#{faker.brand} #{[faker.buzzword,faker.category].sample}"
	desc  = "#{['good','great','perfect','useful','beneficial','fun','nice','enjoyable'].sample} for #{faker.medical_use} and #{faker.buzzword}"
	cast_data = {
		user_id: user[:_id],
		title: title,
		cost_dollars: [5,10,15,20,25].sample,
		desc: desc,
		img_url: PRODUCT_PICS.sample
	}
	$casts.add(cast_data)
end


# def add_seed_data
# 	password = BCrypt::Password.create(password)

# 	users = [
# 		{_id: 'u1', handle: 'u1', email: 'u1@u1.com', name: 'Cannabis City', password: password, seed: true},
# 		# {_id: 'u2', handle: 'u2', email: 'u2@u2.com', name: 'Marley Natural Shop', password: password, seed: true}
# 		# {_id: 'u3', handle: 'u3', email: 'u3@u3.com', name: 'Crop Circle Chocolate', password: password, seed: true}
# 		# {_id: 'u4', handle: 'u4', email: 'u4@u4.com', name: 'Amazon Organics', password: password, seed: true}
# 		# {_id: 'u5', handle: 'u5', email: 'u5@u5.com', name: 'Marley Natural Shop', password: password, seed: true}
# 		# {_id: 'u6', handle: 'u6', email: 'u6@u6.com', name: 'Marley Natural Shop', password: password, seed: true}
# 		# {_id: 'u7', handle: 'u7', email: 'u7@u7.com', name: 'Marley Natural Shop', password: password, seed: true}
# 		# {_id: 'u8', handle: 'u8', email: 'u8@u8.com', name: 'Marley Natural Shop', password: password, seed: true}
# 	]

# 	# pre-rolls, mini-joints, bongs, cartridges, vapes, hash, capsules, gummies, dog treats, chocolates, coffee, tinctures, bud, skin lotion, oils
# 	products = [
# 		{user_id: 'a1', cost_dollars: 10, desc: 'my awesome product'}
# 	]

# 	users.each {|user| $users.update_id(user[:_id], user, {upsert: true }) }
# 	products.each {|cast| $casts.update_id(cast[:_id], cast, {upsert: true }) }
# end


# def add_seed_users
# 	$users.delete_many(seed: true)

# 	$seed_users[:results].to_a.each_with_index do |user, idx| 
# 		puts "idx #{idx}"
# 		name   = "#{user[:name][:first]} #{user[:name][:last]}"
# 		email  = user[:email]
# 		handle = user[:login][:username]

# 		contact = "#{[Faker::Internet.email, email, handle].sample} #{['on Instagram', 'on Facebook', 'on Twitch', 'at gmail', 'on tiktok', 'on reddit',' ',' ',' ',' '].sample}"			
# 		data = {
# 			seed: true,
# 			name: name,
# 			email: email,
# 			handle: handle,
# 			img_url: user[:picture][:medium],
# 			title: SAMPLE_SEARCHES.mapo(:label).sample.to_s[0..-2],
# 			#desc: Faker::Company.bs,
# 			contact: contact
# 		}
# 		$users.add(data)
# 	end
# end

# def remove_seed_users
# 	$users.delete_many(seed: true)
# end


