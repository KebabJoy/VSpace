# frozen_string_literal: true

class Admin < User
  MONEY_STORAGE_ID = 1

  has_many :received_transactions, class_name: 'ExchangeTransaction', as: :to_client
  has_many :sent_transactions, class_name: 'ExchangeTransaction', as: :from_client
end
