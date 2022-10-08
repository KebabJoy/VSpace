# frozen_string_literal: true

class Event < ApplicationRecord
  validates_presence_of :title, :description, :participants_needed

  belongs_to :currency
end
