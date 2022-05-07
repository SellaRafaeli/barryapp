require('csv')

def load_csv(path)
	rows = CSV.read(File.expand_path path)
end

def upsert_users_from_csv(path)
	rows = load_csv(path)
	headers = rows[0].map {|s| s.downcase }
#	rows = rows[0..1000]
	rows.each_with_index do |row,idx|
		next if idx == 0
		email = row[2].to_s.downcase
		next unless email.present?

		city = row[5].to_s.titleize
		phone = row[3]
		data = {
			csv: true,
			csv_version: 'disp2',
			name: row[1],
			handle: row[1],
			email: row[2],
			phone: phone,			
			address: row[4],
			city: city,
			state: row[6],
			website: row[7],
			contact: phone,
			license_numbers: row[8],
			type: 'seller'
		}
		
		puts "#{idx}: #{email}, #{city}"
		begin 
			bp unless $go = true
			if (user = $users.get(email: email))
				$users.update_id(user[:_id], data)
			else
				data[:_id] = nice_id
				$users.add(data)
			end
		rescue => e 
			puts e.to_s.red
		end
		# 
		# puts "no user for email #{email}" unless user 
		# puts "idx: #{idx}, updating #{email}, user_id: #{$users.get(email: email)[:_id]}"
	end

	puts "done."
end

# path = './data/disp2.csv' #'~/Downloads/data_ca_1.csv'
# >> $users.delete_many(csv: true); upsert_users_from_csv('./data/disp2.csv')