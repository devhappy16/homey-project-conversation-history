class Project < ApplicationRecord
  enum :status, [ :todo, :active, :completed ]
end
