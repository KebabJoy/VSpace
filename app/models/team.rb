# frozen_string_literal: true

class Team < ApplicationRecord
  validates_presence_of :name

  belongs_to :leader, class_name: 'Client'

  has_many :clients, class_name: 'Client', foreign_key: 'team_id'
end
