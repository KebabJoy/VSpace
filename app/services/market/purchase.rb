# frozen_string_literal: true

module Market
  class Purchase
    extend Dry::Initializer
    include Dry::Monads::Result::Mixin
    include Dry::Monads::Do.for(:call)

    option :product, required: true
    option :client, required: true

    def call
      yield validate

    end

    private

    def validate
      return Failure(:out_of_stock) if product.amount.zero?

      return Failure(:not_enough_money) unless client.can_buy?(product)

      Success(:ok)
    end
  end
end
