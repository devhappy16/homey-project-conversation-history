class Project < ApplicationRecord
  belongs_to :project_users, optional: true
  has_many :users, through: :project_users
  has_many :project_conversation_histories

  enum :status, [ :todo, :active, :completed ]
end
