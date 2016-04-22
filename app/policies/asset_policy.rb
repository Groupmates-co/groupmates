class AssetPolicy < ApplicationPolicy

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

  attr_reader :user, :asset
 	def initialize(user, asset)
    @user = user
    @asset = asset
  end

  def show?
    asset.user == user or ProjectPolicy.new(user, Project.find(asset.project_id)).show?
  end

  def root?
    asset.user == user or ProjectPolicy.new(user, Project.find(asset.project_id)).show?
  end

  def create?
    asset.user == user or ProjectPolicy.new(user, Project.find(asset.project_id)).show?
  end

  def update?
    asset.user == user or ProjectPolicy.new(user, Project.find(asset.project_id)).show?
  end

  def destroy?
  	asset.user == user or ProjectPolicy.new(user, Project.find(asset.project_id)).show?
  end

  def rename?
    asset.user == user or ProjectPolicy.new(user, Project.find(asset.project_id)).show?
  end

  def versions?
    asset.user == user or ProjectPolicy.new(user, Project.find(asset.project_id)).show?
  end

  def download?
    ProjectPolicy.new(user, Project.find(asset.project_id)).show?
  end



end