# frozen_string_literal: true

class Product < ApplicationRecord
  enum category: { other: 0, clothes: 1, tools: 2 }

  belongs_to :currency
end
