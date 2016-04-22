class NotificationMailer < ActionMailer::Base
	add_template_helper(EmailHelper)
	
	default from: 'Groupmates <notifications@groupmates.uk>'

	def event_email(user,event)
		set_email_attrs(user,event, "You have an event due")
		@event = event
		Rails.logger.info "Sending email to: " + @user.email + " for event: " + @event.title + " in project: " + @project.name
		mail(to: @user.email, subject: 'A deadline in your project "' + @project.name + '" is approaching')
	end

	def unread_email(user,count)
		set_email_attrs(user, "You have new messages")
		@count = count
		mail(to: @user.email, subject: @user.first_name+', you have unread messages')
	end

	def project_unread_email(user,project,count)
		set_email_attrs(user,project, "You have new messages")
		@count = count
		mail(to: @user.email, subject: 'You have unread messages in your project "' +@project.name + '"')
	end

	private

	def set_email_attrs(user, project_child, subtitle)
		@user = user
		@subtitle = subtitle
		@project = (project_child.class == Project ? project_child : project_child.project)
		@url = url_for(controller: 'projects', action: 'dashboard', slug: @project.slug)
	end

end
