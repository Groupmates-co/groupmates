json.array!(@projects) do |json, project|
  json.id   project.id
  json.name project.name
  json.duration project.duration
  json.users project.users do |user|
	  json.first_name user.first_name
	  json.last_name user.last_name
	  json.email user.email
	  json.profile_picture user.profile_picture
  end
end