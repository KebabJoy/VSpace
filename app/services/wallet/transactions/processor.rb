# frozen_string_literal: true

module Wallet
  module Transactions
    class Processor < BaseService
      include Dry::Monads::Do.for(:call)

      option :from_client_id, required: true
      option :to_client_id, required: true
      option :currency, required: true
      option :manager_id
      option :amount, required: true

      def call
        yield set_variables
        yield valid?

        response = HttpClient.new(
          url: request_url(endpoint: endpoint),
          headers: default_headers,
          method: :post
        ).call

        transaction_hash = yield valid_response?(response)
        status = Info.new(transaction_hash: transaction_hash).call
        ExchangeTransaction.create!(
          amount: amount,
          from_client_id: from_client_id,
          to_client_id: to_client_id,
          manager_id: manager_id,
          currency: currency,
          processed: status.success?
        )
        Success(:ok)
      end

      private

      def set_variables
        @manager = Manager.find_by(id: @manager_id)
        @from_client = Client.find_by(id: @from_client_id)
        @to_client = Client.find_by(id: @to_client_id)

        return Failure(:not_found) unless @from_client && @to_client

        Success(:ok)
      end

      def valid?
        return Failure(:not_enough_money) if amount <= ExchangeTransaction::MATIC_COMISSION && currency.to_sym == :matic

        Success(:ok)
      end

      def valid_response?(response)
        return response if response.failure?

        response
      end

      def payload
        {
          fromPrivateKey: @from_client.private_key,
          toPublicKey: @to_client.public_key,
          amount: amount
        }
      end

      def endpoint
        "/v1/transfers/#{currency}"
      end
    end
  end
end