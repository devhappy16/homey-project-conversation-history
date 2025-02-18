class CommentPolicy < ApplicationPolicy
  attr_reader :project

  def index?
    true
  end

  def show?
    false # don't need an individual comment show
  end

  def new?
    return true if user.admin?
    return true if user.manager? && (record.project.manager_user_id == user.id)
    return true if user.member? && user.projects.include?(record.project)

    false
  end

  def edit?
    new?
  end

  def create?
    new?
  end

  def update?
    create?
  end

  def destroy?
    user.admin? || (record.user_id == user.id)
  end
end
