# frozen_string_literal: true

module Api
  module V1
    class AdminsController < BaseController
      include Authable

      private

      def resource
        Admin
      end
    end
  end
end
