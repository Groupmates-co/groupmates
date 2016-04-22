namespace :groupmates do
	
	desc "Migration from single channel to multi channel system"
	task :migrate_to_multi_channel => :environment do
		for project in Project.all do
			channel = Channel.new
			channel.name = "Everyone"
			channel.project = project
			channel.is_main = true
			channel.is_private = false
			for message in Message.where(project_id: project.id) do
				channel.messages << message
			end
			for user in project.users do
				channel.users << user
			end
			channel.save
		end
	end

end