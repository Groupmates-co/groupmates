json.content "We welcome you to your new project. Get a whole new experience of collaborative working using Groupmates ;)"
json.created_at Time.now

json.user do
  json.fullname "#{@message.user.first_name} #{@message.user.last_name}"
  json.profile_picture @message.user.profile_picture
end