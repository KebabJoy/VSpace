# frozen_string_literal: true

class Event < ApplicationRecord
  enum currency: { ruble: 0, matic: 1 }

  validates_presence_of :title, :description, :participants_needed
end
