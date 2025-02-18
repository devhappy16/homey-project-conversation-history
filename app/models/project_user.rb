# model should have been named ProjectMembers (TODO: rename later)
# was initially named ProjectUser because the idea was to have a project association
# with all user role types (admin, manager, member)
class ProjectUser < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validates :project, :user, presence: true
end
