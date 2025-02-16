class Project < ApplicationRecord
  belongs_to :project_users, optional: true
  has_many :users, through: :project_users

  enum :status, [ :todo, :active, :completed ]
end
