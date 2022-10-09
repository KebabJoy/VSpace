# frozen_string_literal: true

class Event < ApplicationRecord
  enum category: { marathon: 0, course: 1, game: 2 }

  validates_presence_of :title, :description, :participants_needed

  belongs_to :currency
  has_many :tasks
end
