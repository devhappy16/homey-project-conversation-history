class CommentPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    index?
  end

  def new?
    index?
  end

  def edit?
    # only allow owner of the comment to edit to maintain authenticity of the message
    record.user == user
  end

  def create?
    index?
  end

  def update?
    edit?
  end

  def destroy?
    user.admin? || edit?
  end
end
