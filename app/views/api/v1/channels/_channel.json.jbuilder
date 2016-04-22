json.name channel.name
json.id channel.id
json.is_private channel.is_private
json.is_one_to_one channel.is_one_to_one(current_user)
json.is_main channel.is_main

json.users channel.users do |user|
	json.first_name user.first_name
	json.last_name user.last_name
	json.email user.email
	json.profile_picture user.profile_picture
	json.id user.id
end