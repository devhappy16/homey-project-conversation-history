FactoryBot.define do
  factory :project_conversation_history do
    association :project
    association :user
    history_type { "project_status_update" }
    previous_value { "todo" }
    new_value { "active" }
  end
end
