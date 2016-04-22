class ProjectPolicy < ApplicationPolicy
	attr_reader :user, :project

	# For index action
  class Scope
  	attr_reader :user, :project

    def initialize(user, project)
      @user = user
      @project = project
    end

    def resolve
    	Project.joins(:users).where(users: { id: @user.id })
    end
  end

  # For the rest 
 	def initialize(user, project)
    @user = user
    @project = project
  end

  def create?
  	true
  end

  def update?
  	@project.creator == @user
  end

  def destroy?
  	@project.creator == @user
  end

	def show?
		@project.users.include?(@user)
  end

end