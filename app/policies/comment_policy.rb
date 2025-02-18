class CommentPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    index?
  end

  def create?
    return true if user.admin?

    return true if user.manager? && record.project.manager_user_id == user.id

    return true if user.member? && user.projects.include?(record.project)

    false
  end

  def new?
    create?
  end

  def update?
    create?
  end

  def edit?
    create?
  end

  def destroy?
    user.admin? || edit?
  end
end
