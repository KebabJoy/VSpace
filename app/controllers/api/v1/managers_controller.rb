# frozen_string_literal: true

module Api
  module V1
    class ManagersController < BaseController
      include Authable

      before_action :obtain_client, only: :generate_nft

      def generate_nft
        response = ::Wallet::Nft::Generator.new(
          image_url: params[:image_url],
          client: @client,
          amount: params[:amount]
        )

        if response.success?
          render json: { success: true }
        else
          render json: { success: false, message: response.failure }
        end
      end

      private

      def obtain_client
        @client ||= Client.find(params[:client_id])
      end

      def resource
        Manager
      end
    end
  end
end
