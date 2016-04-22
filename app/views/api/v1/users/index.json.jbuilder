json.array!(@users) do |json, user|
  json.id   user.id
  json.first_name user.first_name
  json.last_name user.last_name
  json.email user.email
  json.projects user.projects, :id, :name
end