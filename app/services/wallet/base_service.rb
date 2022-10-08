# frozen_string_literal: true

module Wallet
  class BaseService
    extend Dry::Initializer
    include Dry::Monads::Result::Mixin

    BASE_URL = 'https://hackathon.lsp.team/hk'

    protected

    def request_url(endpoint: '')
      BASE_URL + endpoint
    end

    def default_headers
      {
        'Content-Type' => 'application/json',
      }
    end
  end
end
