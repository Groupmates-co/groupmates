class FolderPolicy < ApplicationPolicy

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

  attr_reader :user, :folder
 	def initialize(user, folder)
    @user = user
    @folder = folder
  end

  def show?
    folder.user == user or ProjectPolicy.new(user, Project.find(folder.project_id)).show?
  end

  def create?
    folder.user == user or ProjectPolicy.new(user, Project.find(folder.project_id)).show?
  end

  def update?
    folder.user == user or ProjectPolicy.new(user, Project.find(folder.project_id)).show?
  end

  def destroy?
  	folder.user == user or ProjectPolicy.new(user, Project.find(folder.project_id)).show?
  end

  def download?
    ProjectPolicy.new(user, Project.find(folder.project_id)).show?
  end

end