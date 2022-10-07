# frozen_string_literal: true

module Wallet
  module Nft
    class BalanceInfo < BaseService
      option :client, required: true

      def call
        response = HttpClient.new(
          url: request_url(endpoint: endpoint),
          headers: default_headers,
          method: :get
        ).call

        parsed_response(response)
      end

      private

      def endpoint
        "/v1/wallets/#{client.public_key}/nft/balance"
      end

      def parsed_response(response)
        return [] if response.failure?

        response.success[:balance].map do |nft|
          {
            amount: nft[:tokens].size,
            uri: nft[:uri]
          }
        end
      end
    end
  end
end
