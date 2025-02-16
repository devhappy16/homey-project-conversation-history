class CreateProjectConversationHistories < ActiveRecord::Migration[8.0]
  def change
    create_table :project_conversation_histories do |t|
      t.references :project, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :history_type
      t.text :previous_value
      t.text :new_value

      t.timestamps
    end
  end
end
