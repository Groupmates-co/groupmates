class Project < ActiveRecord::Base

	has_many :assignations
	has_many :users, through: :assignations
	has_many :notes
	has_many :channels
	has_many :events
	has_many :assets
	has_many :folders
	has_many :invitations
	belongs_to :creator, class_name: "User", foreign_key: "creator"
	
	accepts_nested_attributes_for :users,
		:allow_destroy => true

	attr_accessor :stats

	validates :name, presence: true, length: { minimum: 3 }, uniqueness: true
	validates :duration, presence: true

	before_save :generate_slug

	def channel
		"private-project-#{self.id}"
	end

	def users_for_form
		collection = users.where(project_id: id)
    collection.any? ? collection : users.build
  end

  def generate_slug
  	self.slug = self.name.parameterize
  end

  def new_messages?(user)
    self.channels.where(is_private: 0).each do |channel|
      if channel.messages.any?
        message = channel.messages.order(created_at: :desc).first
        return true if (!user.last_project_quit.nil? && message.created_at > user.last_project_quit)
      end
    end
    false
  end

end
