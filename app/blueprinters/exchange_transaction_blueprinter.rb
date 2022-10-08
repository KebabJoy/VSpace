# frozen_string_literal: true

class ExchangeTransactionBlueprinter < Blueprinter::Base
  identifier :id
  fields :title, :amount, :price, :image_url, :category

  field(:currency) do
    currency.kind
  end
end
