json.id   @project.id
json.name @project.name
json.duration @project.duration
json.creator (@project.creator)? @project.creator : nil
json.users @project.users do |user|
	json.id user.id
	json.first_name user.first_name
	json.last_name user.last_name
	json.fullname "#{user.first_name} #{user.last_name}"
	json.email user.email
	json.phone user.phone
  json.skype user.skype
  json.bio user.bio
	json.profile_picture user.profile_picture
	json.last_sign_in_at user.last_sign_in_at
	json.last_project_quit user.last_project_quit
  json.assignment user.assignations.find_by(project: @project).role
end
# json.invitations @project.invitations do |invitation|
# 	json.id invitation.id
# 	json.invited_email invitation.invited_email
# 	json.status invitation.status
# 	json.invited_by_id invitation.invited_by_id
# end