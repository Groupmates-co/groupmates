namespace :groupmates do

	desc "Sends emails to users whose projects have events which are due in an hour."
	task :event_emails => :environment do
		for event in Event.where("happening < ?",Time.now + 1.hour).where("happening > ?", Time.now) do 
			for user in event.users do
				NotificationMailer.event_email(user,event).deliver
			end
		end
	end
	
end