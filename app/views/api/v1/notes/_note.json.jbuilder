json.id    note.id
json.title note.title
json.content note.content
json.permission note.permission
json.project_id note.project ? note.project.id : nil
json.user_id note.user ? note.user.id : nil
json.updated_at  note.updated_at
json.created_at  note.created_at

json.user do
	json.id note.user.id
  json.fullname "#{note.user.first_name} #{note.user.last_name}"
  json.profile_picture note.user.profile_picture
end
