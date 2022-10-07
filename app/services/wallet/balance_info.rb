# frozen_string_literal: true

module Wallet
  class BalanceInfo < BaseService
    option :client, required: true

    def call
      response = HttpClient.new(
        url: request_url(endpoint: endpoint),
        headers: default_headers,
        method: :get
      ).call

      if response.success?
        return client.update!(rubles: response.success[:coinsAmount], matics: response.success[:maticAmount])
      end

      response
    end

    private

    def endpoint
      "/v1/wallets/#{client.public_key}/balance"
    end
  end
end
