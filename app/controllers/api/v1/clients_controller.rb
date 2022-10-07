# frozen_string_literal: true

module Api
  module V1
    class ClientsController < BaseController
      include Authable

      private

      def resource
        Client
      end
    end
  end
end
