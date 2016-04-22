namespace :elasticsearch do
	desc "Re-index Elasticsearch index"
	task :clear_index => :environment do
		User.import
		Message.import
		# Add more when indexed
	end
end
