class NotePolicy < ApplicationPolicy
	
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

  attr_reader :user, :note

 	def initialize(user, note)
    @user = user
    @note = note
  end

  def show?
    ProjectPolicy.new(user, Project.find(note.project_id)).show?
  end

  def create?
    note.user == user or ProjectPolicy.new(user, Project.find(note.project_id)).show?
  end

  def update?
    note.user == user or ProjectPolicy.new(user, Project.find(note.project_id)).show?
  end

  def destroy?
  	note.user == user or ProjectPolicy.new(user, Project.find(note.project_id)).show?
  end

end