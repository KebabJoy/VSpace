# frozen_string_literal: true

FactoryBot.define do
  factory :forum do
    title { Faker::Lorem.paragraph(sentence_count: 3) }
    description { Faker::Lorem.paragraph(sentence_count: 3) }
    creator { create(:client) }
    topic { create(:topic) }
  end
end
