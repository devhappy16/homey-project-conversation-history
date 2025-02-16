class ProjectPolicy < ApplicationPolicy
  def index?
    user.admin? || (user.projects.include? record)
  end

  def show?
    index?
  end

  def new?
    # only admin can create new projects
    user.admin?
  end

  def edit?
    user.admin? || (user.manager? && (user.projects.include? record))
  end

  def create?
    new?
  end

  def update?
    edit?
  end

  def destroy?
    # only admins can delete projects
    new?
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      # TODO: implement pundit scoping later
      # scope.where(project_id)
      scope.all
    end

    private

    attr_reader :user, :scope
  end
end
