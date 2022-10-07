# frozen_string_literal: true

module Api
  module V1
    class EditorsController < BaseController
      include Authable

      private

      def resource
        Editor
      end
    end
  end
end
