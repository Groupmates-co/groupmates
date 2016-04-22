class EventPolicy < ApplicationPolicy
	attr_reader :user, :event

  # For index action
  class Scope
    attr_reader :user, :scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.where(project: user.projects)
    end
  end

  # For the rest
 	def initialize(user, event)
    @user = user
    @event = event
  end

  def create?
    ProjectPolicy.new(user, Project.find(event.project.id)).show?
  end

  def show?
    ProjectPolicy.new(user, Project.find(event.project_id)).show?
  end

  def update?
    ProjectPolicy.new(user, Project.find(event.project_id)).show?
  end

  def destroy?
    ProjectPolicy.new(user, Project.find(event.project_id)).show?
  end

end