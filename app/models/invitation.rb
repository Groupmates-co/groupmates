class Invitation < ActiveRecord::Base
  belongs_to :invited_by, class_name: "User", foreign_key: "invited_by_id"
  belongs_to :project, class_name: "Project", foreign_key: "project_id"
  before_save :generate_token!

  validates :invited_email, presence: true
  validates_uniqueness_of :invited_email, :scope => [:project_id]

  # Invitation Status
  # 1: Not approved / Not joined
  # 2: Approved / Not joined
  # 3: Not approved / Joined
  # 4: Completed
  #
  # Approved: (Not) approved by the project creator
  # Joined: Did (not) ask to join the project
  NOT_APPROVED_NOT_JOINED = 1
  APPROVED_NOT_JOINED = 2
  NOT_APPROVED_JOINED = 3
  COMPLETED = 4
  DECLINED = 5

  private 
  	def generate_token!
			self.invitation_token = loop do
			  token = SecureRandom.urlsafe_base64
			  break token unless Invitation.exists?(invitation_token: token)
			end
  	end
end
