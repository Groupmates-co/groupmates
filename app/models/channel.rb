class Channel < ActiveRecord::Base

	belongs_to :project
	has_many :messages, dependent: :destroy
	has_and_belongs_to_many :users, dependent: :destroy, inverse_of: :channels, :after_add => :push_member_join, :after_remove => :push_member_leave
	accepts_nested_attributes_for :users, reject_if: :all_blank, allow_destroy: true
	has_many :msg_views, dependent: :destroy

	validates :name, presence: true, length: { minimum: 3 }

	def channel
		"private-project-#{project.id}"
	end

	def user_ids=(user_ids)    
		self.users = User.find(user_ids)
  	end	

  def set_main_channel(project, user)
  	self.is_private = false
		self.is_main = true
		self.name = "Everyone"
		self.project = project
		self.users << user
	end

  def is_one_to_one(current_user)
  	self.users.include?(current_user) && self.users.size == 2 && self.is_private
  end

  def push_member_join(member)
  	Pusher.trigger(self.channel, 'new_member_join', {
  		user: member.as_json(only: [:id, :first_name, :last_name, :email, :last_sign_in_at], :methods => [:profile_picture]),
  		channel: self.id
  	}) if self.id
  end

  def push_member_leave(member)
  	Pusher.trigger(self.channel, 'new_member_leave', {
  		user: member.as_json(only: [:id, :first_name, :last_name, :email, :last_sign_in_at], :methods => [:profile_picture]),
  		channel: self.id
  	}) if self.id
  end

end
