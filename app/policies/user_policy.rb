class UserPolicy < ApplicationPolicy
	attr_reader :current_user, :model

 	def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  def current?
    true
  end

  def updateproject?
    @current_user == @user
  end

  def update?
    @current_user == @user
  end

	def show?
    @current_user == @user
  end

end