class ReviewPolicy < ApplicationPolicy
 	def initialize(user, review)
    @user = user
    @review = review
  end

  def create?
    @user
  end

  def index?
    false
  end

  def update?
  	false
  end

  def destroy?
  	false
  end

	def show?
		false
  end
end
