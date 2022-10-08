# frozen_string_literal: true

class Currency < ApplicationRecord
  self.table_name = 'currencies'

  enum kind: { ruble: 0, matic: 1 }
end
