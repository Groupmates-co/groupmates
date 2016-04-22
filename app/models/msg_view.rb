class MsgView < ActiveRecord::Base	
	
	belongs_to :channel
	belongs_to :user
	belongs_to :message

	validates_uniqueness_of :user_id, :scope => [:channel_id]
	
end
