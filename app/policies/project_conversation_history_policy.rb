class ProjectConversationHistoryPolicy < ApplicationPolicy
  def index?
    user.admin? || (user.projects.include? record.project)
  end

  def show?
    index?
  end

  def new?
    false
  end

  def edit?
    false
  end

  def create?
    false
  end

  def update?
    false
  end

  def destroy?
    false
  end
end
