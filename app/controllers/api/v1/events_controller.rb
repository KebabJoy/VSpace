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
        @task = Task.new(event_id: params[:event_id], client: current_member)

        if @task.save
          render(
            json: {
              success: true,

            }
          )
        else
          render json: { success: false, message: event.errors.full_message }, status: 400
        end
      end

      private

      def resource
        Client
      end
    end
  end
end
