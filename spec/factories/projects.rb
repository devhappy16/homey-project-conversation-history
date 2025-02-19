FactoryBot.define do
  factory :project do
    sequence(:name) { |n| "Project #{n}" }
    description { "A test project" }
    status { "todo" }
    association :manager_user, factory: :user

    trait :active do
      status { "active" }
    end

    trait :completed do
      status { "completed" }
    end
  end
end
