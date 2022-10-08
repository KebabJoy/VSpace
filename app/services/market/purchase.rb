# frozen_string_literal: true

module Market
  class Purchase
    extend Dry::Initializer
    include Dry::Monads::Result::Mixin
    include Dry::Monads::Do.for(:call)

    option :product, required: true
    option :client, required: true

    def call
      return Success(product.update!(amount: product.amount - 1)) if product.price.zero?

      yield validate

      response = ::Wallet::Transactions::Processor.new(
        from_client_id: client.id,
        to_client_id: Admin::MONEY_STORAGE_ID,
        currency: product.currency.kind,
        amount: product.price,
      ).call

      yield process_response(response.success)
    end

    private

    def validate
      return Failure(:out_of_stock) if product.amount.zero?

      return Failure(:not_enough_money) if client.matics + ExchangeTransaction::MATIC_COMISSION < product.price

      Success(:ok)
    end

    def process_response(response)
      return response if response.failure?

      product.update!(amount: product.amount - 1)
      order = Order.create!(client: client, product: product)

      Success(order)
    end
  end
end
