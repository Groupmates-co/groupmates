class ChannelUserPolicy < ApplicationPolicy
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
    true
  end

  def show?
    true
  end

  def update?
    true
  end

  def destroy?
    true
  end

end