# frozen_string_literal: true

module Api
  module V1
    module Managers
      class ExchangesController < BaseController
        def create
          response = ::Wallet::Transactions::Processor.new(
            from_client_id: permitted_params[:from_client],
            to_client_id: permitted_params[:to_client],
            currency: permitted_params[:currency],
            amount: permitted_params[:amount],
            manager_id: current_member.id,
          ).call

          if response.success?
            render json: { success: true }, status: 200
          else
            render json: { success: false, message: response.failure }, status: 400
          end
        end

        private

        def permitted_params
          params.require(:exchange).permit(:from_client, :to_client, :currency, :amount)
        end

        def resource
          Manager
        end
      end
    end
  end
end
