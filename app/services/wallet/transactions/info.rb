# frozen_string_literal: true

module Wallet
  module Transactions
    class Info < BaseService
      option :transaction_hash, required: true

      def call
        response = HttpClient.new(
          url: request_url(endpoint: endpoint),
          headers: default_headers,
          method: :get
        ).call

        yield valid_response?(response)
      end

      private

      def endpoint
        "/v1/transfers/status/#{transaction_hash}"
      end

      def valid_response?(response)
        return response if response.failure?

        Success(:ok)
      end
    end
  end
end
