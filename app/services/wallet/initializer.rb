# frozen_string_literal: true

module Wallet
  class Initializer < BaseService
    ENDPOINT = '/v1/wallets/new'

    option :client, required: true

    def call
      response = HttpClient.new(
        url: request_url(endpoint: ENDPOINT),
        headers: default_headers,
        method: :post
      ).call

      if response.success?
        client.assign_attributes(parsed_attributes(response.success))
        client.save!
      end
    end

    private

    def parsed_attributes(response)
      { public_key: response[:publicKey], private_key: response[:privateKey] }
    end
  end
end
