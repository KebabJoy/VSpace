# frozen_string_literal: true

class Manager < User
  has_many :received_transactions, class_name: 'ExchangeTransaction', as: :to_client
  has_many :sent_transactions, class_name: 'ExchangeTransaction', as: :from_client
end
