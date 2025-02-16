class ProjectConversationHistory < ApplicationRecord
  belongs_to :project
  belongs_to :user

  enum :history_type, [ :project_status_update, :comment_created, :comment_updated, :comment_deleted ]
end
