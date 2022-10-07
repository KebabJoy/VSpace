# frozen_string_literal: true

module Api
  module V1
    class ManagersController < BaseController
      include Authable

      private

      def resource
        Manager
      end
    end
  end
end
