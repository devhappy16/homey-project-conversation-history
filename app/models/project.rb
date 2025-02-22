class Project < ApplicationRecord
  belongs_to :manager_user, class_name: "User", optional: true, foreign_key: "manager_user_id"
  has_many :project_users
  has_many :users, through: :project_users
  has_many :project_conversation_histories
  has_many :comments

  validates :name, presence: true

  enum :status, [ :todo, :active, :completed ]

  after_update :create_status_change_conversation_history, if: :saved_change_to_status?

  private

  def create_status_change_conversation_history
    previous_status, new_status = saved_change_to_status

    project_conversation_histories.create!(
      history_type: ProjectConversationHistory.history_types[:project_status_update],
      user: Current.user,
      previous_value: previous_status,
      new_value: new_status
    )
  end
end
