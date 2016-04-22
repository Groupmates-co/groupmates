json.id user.id
json.fullname "#{user.first_name} #{user.last_name}"
json.first_name user.first_name
json.last_name user.last_name
json.email user.email
json.phone user.phone
json.skype user.skype
json.bio user.bio
json.profile_picture user.profile_picture
json.last_project_opened user.last_project_opened 
json.last_project_quit user.last_project_quit
json.last_sign_in_at user.last_sign_in_at
json.assignment ( user.assignations.find_by(project: user.last_project_opened).nil? ? "Unassigned" : user.assignations.find_by(project: user.last_project_opened).role )