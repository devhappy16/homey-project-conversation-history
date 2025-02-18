class AddManagerUserIdToProjects < ActiveRecord::Migration[8.0]
  def change
    add_column :projects, :manager_user_id, :integer
  end
end
