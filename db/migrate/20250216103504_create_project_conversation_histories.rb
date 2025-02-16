class CreateProjectConversationHistories < ActiveRecord::Migration[8.0]
  def change
    create_table :project_conversation_histories do |t|
      t.references :project, null: false, foreign_key: true
      t.integer :history_type

      t.timestamps
    end
  end
end
