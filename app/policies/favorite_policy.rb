class FavoritePolicy < ApplicationPolicy
	attr_reader :user, :favorite
 	
  # For index action
  class Scope
    attr_reader :user, :scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.where(user: user.id)
    end
  end

  def initialize(user, favorite)
    @user = user
    @favorite = favorite
  end

  def create?
    favorite.user == @user or ProjectPolicy.new(user, Project.find(favorite.message.channel.project_id)).show?
  end

  def update?
    false
  end

  def destroy?
  	favorite.user == @user or ProjectPolicy.new(user, Project.find(favorite.message.channel.project_id)).show?
  end

end