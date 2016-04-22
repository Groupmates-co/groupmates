class ChannelUser < ActiveRecord::Base	
	
	belongs_to :channel, inverse_of: :channel_users
	belongs_to :user, inverse_of: :channel_users

	self.table_name = "channel_users"
	
	def project_id
		return channel.project.id
	end

end
