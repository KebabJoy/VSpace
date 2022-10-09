# frozen_string_literal: true

module Wallet
  module Nft
    class Generator < BaseService
      ENDPOINT = '/v1/nft/generate'

      option :image_url, required: true
      option :client, required: true
      option :amount, required: true

      def call
        HttpClient.new(
          url: request_url(endpoint: ENDPOINT),
          body: payload,
          headers: default_headers,
          method: :post
        ).call
      end

      private

      def payload
        {
          toPublicKey: client.public_key,
          uri: image_url,
          nftCount: amount
        }
      end
    end
  end
end
