# frozen_string_literal: true

module Api
  module V1
    class EventsController < BaseController
      def index
        events = Event.where('deadline > ?', Time.now).group_by(&:category)

        render json: {
          success: true,
          **::EventBlueprinter.render_as_hash(events['game'] || Event.none, root: :games),
          **::EventBlueprinter.render_as_hash(events['marathon'] || Event.none, root: :marathons),
          **::EventBlueprinter.render_as_hash(events['course'] || Event.none, root: :courses),
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
          render json: { success: false, message: event.errors.full_messages }, status: 400
        end
      end

      private

      def resource
        Client
      end
    end
  end
end
