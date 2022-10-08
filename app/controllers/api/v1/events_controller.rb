# frozen_string_literal: true

module Api
  module V1
    class EventsController < BaseController
      def index
        events = Event.order(created_at: :desc)

        render json: {
          success: true,
          **::EventBlueprinter.render_as_hash(events, root: :events),
          count: events.size,
        }, status: 200
      end

      def take

      end

      private

      def filter_params

      end
    end
  end
end
