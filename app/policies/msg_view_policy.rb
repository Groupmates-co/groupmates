class MsgViewPolicy < ApplicationPolicy
	attr_reader :user, :msg_view

  # For index action
  class Scope
    attr_reader :user, :channel, :scope
    def initialize(user, channel, scope)
      @user = user
      @channel = channel
      @scope = scope
    end

    def resolve
      scope.where(channel: channel, user: channel.users)
    end
  end

 	def initialize(user, msg_view)
    @user = user
    @msg_view = msg_view
  end

  def view?
    msg_view.user == @user and ProjectPolicy.new(user, Project.find(msg_view.channel.project_id)).show?
  end

  def create?
    msg_view.user == @user and ProjectPolicy.new(user, Project.find(msg_view.channel.project_id)).show?
  end

  def show?
    ProjectPolicy.new(user, Project.find(msg_view.channel.project_id)).show?
  end

  def update?
    msg_view.user == @user and ProjectPolicy.new(user, Project.find(msg_view.channel.project_id)).show?
  end

  def destroy?
    ProjectPolicy.new(user, Project.find(msg_view.channel.project_id)).show?
  end

end