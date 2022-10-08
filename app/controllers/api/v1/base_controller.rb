# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      skip_before_action :verify_authenticity_token

      before_action :authorize!

      # rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing
      rescue_from ActiveRecord::RecordNotFound, with: :not_found

      def handle_parameter_missing(exception)
        render json: { success: false, message: exception.message.capitalize }, status: 400
      end

      def authorize!
        render json: { success: false, message: 'Unauthorized' }, status: 403 unless current_member
      end

      def current_member
        @current_member ||= resource.find_by(auth_token: params[:auth_token])
      end
    end
  end
end
