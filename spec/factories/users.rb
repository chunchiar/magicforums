FactoryGirl.define do
    factory :user do
      email "user@gmail.com"
      username "bob"
      password "password"

    factory :unknown_user do
      email "niluser@gmail.com"
      username "niluser"
      password "password"
    end

      trait :with_image do
      image { fixture_file_upload("#{::Rails.root}/spec/fixtures/white_bear.jpg") }
    end

    trait :sequenced_email do
      sequence(:email) { |n| "user#{n}@gmail.com" }
    end

    trait :sequenced_username do
      sequence(:username) { |n| "username#{n}@gmail.com" }
    end

    trait :admin do
      role :admin
      sequence(:email) { |n| "admin#{n}@gmail.com" }
      sequence(:username) { |n| "admin#{n}" }
    end

    trait :moderator do
      role :moderator
      sequence(:email) { |n| "moderator#{n}@gmail.com" }
      sequence(:username) { |n| "moderator#{n}" }
    end

    end
  end
