# frozen_string_literal: true

module Api
  module V1
    class ExchangesController < BaseController
      before_action :obtain_currency, only: :create

      def create
        response = ::Wallet::Transactions::Processor.new(
          from_client_id: current_member.id,
          to_client_id: permitted_params[:to_client],
          currency: @currency,
          amount: permitted_params[:amount],
        ).call

        if response.success?
          render json: { success: true }, status: 200
        else
          render json: { success: false, message: response.failure }, status: 400
        end
      end

      private

      def permitted_params
        params.permit(:to_client, :currency, :amount)
      end

      def obtain_currency
        @currency ||= Currency.find_by(kind: params[:currency])
      end
    end
  end
end
