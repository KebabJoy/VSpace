# frozen_string_literal: true

module Api
  module V1
    class ReactionsController < BaseController
      def create
        result = Forum::Reactions::Processor.new(client: current_member, **permitted_params.to_h.symbolize_keys).call

        if result.success?
          render json: { success: true }, status: 200
        end
      end

      private

      def permitted_params
        params.require(:ratable).permit(:entity_type, :entity_id, :value)
      end

      def resource
        Client
      end
    end
  end
end
