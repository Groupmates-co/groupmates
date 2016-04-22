json.id favorite.id
json.user_id favorite.user ? favorite.user.id : nil
json.message_id favorite.message ? favorite.message.id : nil
json.content favorite.content
json.project_id favorite.project_id

json.user do
	json.id favorite.message.user.id
  json.fullname "#{favorite.message.user.first_name} #{favorite.message.user.last_name}"
  json.profile_picture favorite.message.user.profile_picture
end

json.message do
	json.id favorite.message.id
	json.content format_content_assets(favorite.message)
	json.created_at favorite.message.created_at
	json.channel do
		json.id favorite.message.channel.id
		json.name favorite.message.channel.name
	end
	json.created_at favorite.message.created_at
end

