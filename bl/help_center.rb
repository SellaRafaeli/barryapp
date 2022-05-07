# $help_center = $mongo.collection('help_center')

# HC_KEY = 'help_center'

# default_help_center = {section: {title: 'text'} }

# $help_center.update_id(HC_KEY, {help_center: default_help_center}, {upsert: true})

# def get_help_center_content
# 	$help_center.get(HC_KEY)[:help_center]
# end

# post '/admin/help_center' do 
# 	$help_center.update_id(HC_KEY, help_center: pr[:help_center])
# 	redirect back
# end