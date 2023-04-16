# frozen_string_literal: true

FactoryBot.define do
  factory :client do
    sequence(:email) { |n| "new_email_#{n}@example.com" }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    auth_token { SecureRandom.uuid }
    password { "qwerty" }
  end
end
