# frozen_string_literal: true

module Api
  module V1
    module Managers
      class ExhangesController < BaseController
        before_action :authorize!

        def create
          response = ::Wallet::Transactions::Processor.new(
            from_client_id: permitted_params[:from_client],
            to_client_id: permitted_params[:to_client],
            currency: permitted_params[:currency],
            amount: permitted_params[:amount],
            manager_id: permitted_params[:manager],
          ).call

          if response.success?
            render json: { success: true }, status: 200
          else
            render json: { success: false, message: response.failure }, status: 400
          end
        end

        private

        def authorize!
          render json: { success: false, message: 'Forbidden' }, status: 403
        end

        def permitted_params
          params.require(:exchange).permit(:from_client, :to_client, :currency, :amount, :manager)
        end
      end
    end
  end
end
