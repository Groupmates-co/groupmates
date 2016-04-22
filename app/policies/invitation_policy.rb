class InvitationPolicy < ApplicationPolicy
	attr_reader :user, :invitation

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

 	def initialize(user, invitation)
    @user = user
    @invitation = invitation
  end

  def create?
    invitation.invited_by == user or ProjectPolicy.new(user, Project.find(invitation.project_id)).show?
  end

  def show?
    ProjectPolicy.new(user, Project.find(invitation.project_id)).show?
  end

  def update?
    invitation.project.creator == user
  end

  def destroy?
  	false
  end

end
