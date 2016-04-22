namespace :groupmates do
	
	desc "Adds project_id to all favorites which don't have it"
	task :add_project_to_favorites => :environment do
		for favorite in Favorite.all do 
			if (favorite.project == nil)
				favorite.project = favorite.message.channel.project
				favorite.save
			end
		end
	end

	desc "Notify users with unread messages"
	task :notify_unread_msg => :environment do
		puts "Let's start"
		for user in User.all
			for project in user.projects
				unread = user.get_unread_messages(project)

				# If at least on unread messages
				if unread > 0
					#if user.last_notifed_at and (((user.last_notifed_at-Time.now).to_i / 3600) < 24
						# po
					# notified_ago = (user.last_notifed_at-Time.now).to_i / 3600
					# puts notified_ago
				end

			end
		end
	end

	desc "Finds users with multiple unread messages"
	task :find_users_with_unread => :environment do

		# Params: 
		# - channel_unread_limit : If there are more than X new messages send email
		# - unread_limit : If there are more than X new messages across all channels send email
		# - buffer_time : Time between last seen message and now to send email
		channel_unread_limit = 5
		unread_limit = 10
		buffer_time = 1.hours
		
		for user in User.all do
			notified = false
			total_unread = 0
			for project in user.projects do
				preferences = user.preferences.where(project: project).first
				hour_now = Time.now.hour
				if (preferences != nil && hour_now >= preferences.from_time && hour_now <= preferences.to_time)
					for channel in project.channels do
						view = MsgView.where(user: user, channel: channel).first
						if (!view.nil?)
							message = view.message
							messages = Message.where(channel: channel, created_at: message.created_at..Time.now)
							channel_unread = messages.count
							total_unread += channel_unread
							delta_time = Time.now - view.created_at
							if (channel_unread > channel_unread_limit && !notified && delta_time > buffer_time)
								NotificationMailer.unread_email(user,channel,channel_unread).deliver
								notified = true
							end
						end
					end
					if (total_unread > unread_limit && !notified)
						NotificationMailer.project_unread_email(user,project,total_unread).deliver
					end
				end
			end
		end
	end

end