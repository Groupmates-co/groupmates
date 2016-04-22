class Event < ActiveRecord::Base
	belongs_to :project
	has_and_belongs_to_many :users, class_name: "User"
	accepts_nested_attributes_for :users, reject_if: :all_blank, allow_destroy: true

	validates :title, length: { minimum: 2 }, presence: true
	validates :happening, presence: true

  # 
  # http://stackoverflow.com/questions/10717797/rails-nested-form-on-many-to-many-how-to-prevent-duplicates
  # http://stackoverflow.com/questions/9864501/recordnotfound-with-accepts-nested-attributes-for-and-belongs-to
  # http://stackoverflow.com/questions/3969025/accepts-nested-attributes-for-with-belongs-to-polymorphic
  #
	def user_ids=(user_ids)    
		self.users = User.find(user_ids)
  end

end
