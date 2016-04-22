class AssignationPolicy < ApplicationPolicy
	attr_reader :user, :assignment

  # For the rest
 	def initialize(user, assignment)
    @user = user
    @assignment = assignment
  end

  def update?
    ProjectPolicy.new(user, Project.find(assignment.project_id)).show?
  end
end