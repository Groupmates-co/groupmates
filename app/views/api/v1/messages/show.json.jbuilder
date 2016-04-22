json.id    @message.id
json.content format_content_assets(@message)
json.channel_id @message.channel ? @message.channel.id : nil
json.created_at @message.created_at ? @message.created_at : nil

json.user do
  json.fullname "#{@message.user.first_name} #{@message.user.last_name}"
  json.profile_picture @message.user.profile_picture
end
