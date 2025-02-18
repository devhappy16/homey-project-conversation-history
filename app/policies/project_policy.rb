class ProjectPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.admin? || (record.manager_user_id == user.id) || (user.projects.include? record)
  end

  def create?
    user.admin?
  end

  def new?
    create?
  end

  def update?
    user.admin? || (record.manager_user_id == user.id)
  end

  def edit?
    update?
  end

  def destroy?
    user.admin?
  end

  class Scope < Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      elsif user.manager?
        scope.where(manager_user_id: user.id)
      else # user.member?
        user.projects
      end
    end

    private

    attr_reader :user, :scope
  end
end
