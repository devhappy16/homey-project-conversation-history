class Comment < ApplicationRecord
  belongs_to :project
  belongs_to :user

  after_create :create_conversation_history_for_comment_create
  after_update :create_conversation_history_for_comment_update
  after_destroy :create_conversation_history_for_comment_delete

  private

  def create_conversation_history_for_comment_create
    project.project_conversation_histories.create!(
      history_type: ProjectConversationHistory.history_types[:comment_created],
      user: User.first,
      previous_value: nil,
      new_value: "[comment-id-#{id}] #{message}"
    )
  end

  def create_conversation_history_for_comment_update
    previous_message, new_message = saved_change_to_message

    project.project_conversation_histories.create!(
      history_type: ProjectConversationHistory.history_types[:comment_updated],
      user: User.first,
      previous_value: "[comment-id-#{id}] #{previous_message}",
      new_value: "[comment-id-#{id}] #{new_message}"
    )
  end

  def create_conversation_history_for_comment_delete
    project.project_conversation_histories.create!(
      history_type: ProjectConversationHistory.history_types[:comment_deleted],
      user: User.first,
      previous_value: "[comment-id-#{id}] #{message}",
      new_value: "DELETED"
    )
  end
end
