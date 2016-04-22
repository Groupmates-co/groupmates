class ChannelPolicy < ApplicationPolicy
	attr_reader :user, :channel

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

 	def initialize(user, channel)
    @user = user
    @channel = channel
  end

  def create?
    channel.users.include?(@user) and ProjectPolicy.new(user, Project.find(channel.project_id)).show?
  end

  def show?
    channel.users.include?(@user) and ProjectPolicy.new(user, Project.find(channel.project_id)).show?
  end

  #Temporarily allowing all users to update channels
  def update?
    #channel.users.include?(@user) and 
    ProjectPolicy.new(user, Project.find(channel.project_id)).show?
  end

  def destroy?
    channel.users.include?(@user) and ProjectPolicy.new(user, Project.find(channel.project_id)).show?
  end

end