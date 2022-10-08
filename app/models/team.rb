# frozen_string_literal: true

class Team < ApplicationRecord
  belongs_to :leader, class_name: 'Client'

  validates_presence_of :name
end
