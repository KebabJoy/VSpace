# frozen_string_literal: true

class ExchangeTransaction < ApplicationRecord
  MATIC_COMISSION = 2e-1

  enum currency: { ruble: 0, matic: 1 }

  validates_presence_of :currency, :to_client_id, :from_client_id, :managers_id

  belongs_to :to_client, class_name: 'Client', foreign_key: 'to_client_id'
  belongs_to :from_client, class_name: 'Client', foreign_key: 'from_client_id'
  belongs_to :manager, class_name: 'Manager', foreign_key: 'managers_id'
end
