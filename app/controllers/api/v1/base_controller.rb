# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      protect_from_forgery with: :null_session
      # before_action :authorize!

      rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing
      rescue_from ActiveRecord::RecordNotFound, with: :not_found

      def handle_parameter_missing(exception)
        render json: { error: true, message: exception.message.capitalize }, status: 400
      end

      def authorize!
        unless request.headers['Authorization'] == 'Token = 123456'
          render json: { error: true, message: 'Unauthorized' }, status: 403
        end
      end
    end
  end
end
