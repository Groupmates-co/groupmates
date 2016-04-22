json.id    invitation.id
json.invited_email invitation.invited_email
json.status invitation.status
json.project_id invitation.project ? invitation.project.id : invitation.project_id
json.created_at invitation.created_at

if invitation.invited_by
	json.invited_by do
  	json.fullname "#{invitation.invited_by.first_name} #{invitation.invited_by.last_name}"
  	json.profile_picture invitation.invited_by.profile_picture
	end
end
