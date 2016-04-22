class AccountMailer < ActionMailer::Base
  default from: "Groupmates <join@groupmates.uk>"

  def invitation_email(current_user,invitation)
		@url = url_for(
			:controller => 'registrations', 
			:action => 'new', 
			:invitation_token => invitation.invitation_token)
		@current_user = current_user
		@invitation = invitation
		mail(to: @invitation.invited_email, subject: 'You are invited to join a project on Groupmates')
  end
end