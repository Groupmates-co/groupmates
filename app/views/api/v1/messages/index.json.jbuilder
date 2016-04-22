json.array!(@messages) do |json, message|
  json.id    message.id
  json.content format_content_assets(message)

  json.channel_id message.channel ? message.channel.id : nil
	
	json.user do
    json.id message.user.id
  	#json.name message.user.first_name
  	#json.last_name message.user.last_name
  	json.fullname "#{message.user.first_name} #{message.user.last_name}"
  	json.profile_picture message.user.profile_picture
	end
	
  json.created_at message.created_at
end