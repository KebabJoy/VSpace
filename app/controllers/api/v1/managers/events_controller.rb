# frozen_string_literal: true

module Api
  module V1
    module Managers
      class EventsController < BaseController
        def create
          event = Event.new(permitted_params)

          if event.save
            render(
              json: {
                success: true,
                **::EventBlueprinter.render_as_hash(event, root: :event),
              }, status: 200
            )
          else
            render json: { success: false, message: event.errors.full_message }, status: 400
          end
        end

        private

        def permitted_params
          params.require(:event).permit(
            :title,
            :description,
            :deadline,
            :reward,
            :currency,
            :participants_needed,
            :experience,
            :category,
          )
        end
      end
    end
  end
end
