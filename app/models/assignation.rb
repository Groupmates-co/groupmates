class Assignation < ActiveRecord::Base	
	belongs_to :project, inverse_of: :assignations
	belongs_to :user, inverse_of: :assignations

	validates_uniqueness_of :user_id, :scope => [:project_id]
	self.table_name = "projects_users"

  self.primary_keys = :user_id, :project_id
end
