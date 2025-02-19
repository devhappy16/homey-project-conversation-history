FactoryBot.define do
  factory :user do
    sequence(:email_address) { |n| "user#{n}@example.com" }
    password { "password123" }
    role { User.roles[:member] }

    trait :admin do
      role { User.roles[:admin] }
    end

    trait :manager do
      role { User.roles[:manager] }
    end
  end
end
