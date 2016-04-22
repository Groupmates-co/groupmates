class MessagePolicy < ApplicationPolicy
	attr_reader :user, :message

  # For index action
  class Scope
    attr_reader :user, :channel, :scope
    def initialize(user, channel, scope)
      @user = user
      @channel = channel
      @scope = scope
    end

    def resolve
      # Load messages for users in that channel only OR if user is Groupmates assistant
      scope.where('(channel_id = ? AND  user_id IN (?)) OR user_id = ?', 
        channel.id, 
        channel.users.map(&:id),
        User.find_by(admin: 2).id)
    end
  end

  # For the rest
 	def initialize(user, message)
    @user = user
    @message = message
  end

  def create?
    message.user == @user and ProjectPolicy.new(user, Project.find(message.channel.project_id)).show?
  end

  def show?
    ProjectPolicy.new(user, Project.find(message.channel.project_id)).show?
  end

  def update?
    false
  end

  def destroy?
  	false
  end

end

