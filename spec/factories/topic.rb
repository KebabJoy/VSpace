# frozen_string_literal: true

FactoryBot.define do
  factory :topic, class: 'Forum::Topic' do
    title { Faker::Lorem.paragraph(sentence_count: 3) }
    description { Faker::Lorem.paragraph(sentence_count: 3) }
  end
end
