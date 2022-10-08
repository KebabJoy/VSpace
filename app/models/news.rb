# frozen_string_literal: true

class News < ApplicationRecord
  self.table_name = 'news'

  validates_presence_of :title, :body, :manager

  belongs_to :manager
end
