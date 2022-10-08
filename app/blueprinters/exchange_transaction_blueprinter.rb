# frozen_string_literal: true

class ExchangeTransactionBlueprinter < Blueprinter::Base
  identifier :id
  fields :amount

  field(:currency) do |obj, _o|
    obj.currency.kind
  end

  field(:from_client) do |obj, _o|
    obj.from_client.first_name + ' ' + obj.from_client.last_name
  end

  field(:to_client) do |obj, _o|
    obj.to_client.first_name + ' ' + obj.to_client.last_name
  end
end
