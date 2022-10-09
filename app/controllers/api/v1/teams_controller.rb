# frozen_string_literal: true

module Api
  module V1
    class TeamsController < BaseController
      skip_before_action :authorize!

      def index
        teams = Team.all

        render(
          json: {
            success: true,
            **::TeamBlueprinter.render_as_hash(teams, root: :teams),
          }, status: 200
        )
      end
    end
  end
end
