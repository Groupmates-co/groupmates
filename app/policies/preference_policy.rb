class PreferencePolicy < ApplicationPolicy
	
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

  attr_reader :user, :preference

 	def initialize(user, preference)
    @user = user
    @preference = preference
  end

  def show?
    ProjectPolicy.new(user, Project.find(preference.project_id)).show?
  end

  def create?
    preference.user == user or ProjectPolicy.new(user, Project.find(preference.project_id)).show?
  end

  def update?
    preference.user == user or ProjectPolicy.new(user, Project.find(preference.project_id)).show?
  end

  def destroy?
  	preference.user == user or ProjectPolicy.new(user, Project.find(preference.project_id)).show?
  end

end