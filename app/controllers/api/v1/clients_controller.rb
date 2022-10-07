# frozen_string_literal: true

module Api
  module V1
    class ClientsController < BaseController
      include Authable

      after_action :create_wallet, only: :create

      private

      def create_wallet
        ::Wallet::Initializer.new(client: @user).call if @user.persisted?
      end

      def resource
        Client
      end
    end
  end
end
