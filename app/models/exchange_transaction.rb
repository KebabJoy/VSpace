# frozen_string_literal: true

class ExchangeTransaction < ApplicationRecord
  MATIC_COMISSION = 2e-1

  belongs_to :currency
  belongs_to :to_client, foreign_key: 'to_client_id', polymorphic: true
  belongs_to :from_client, foreign_key: 'from_client_id', polymorphic: true

  validates_presence_of :currency, :from_client_id
end
