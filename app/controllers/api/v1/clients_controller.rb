# frozen_string_literal: true

module Api
  module V1
    class ClientsController < BaseController
      include Authable

      def leaderboard
        render(
          json: {
            **LeaderboardBlueprinter.render_as_hash(Client.monthly_leaders, root: :monthly, options: { time_ago: 1.month.ago }),
            **LeaderboardBlueprinter.render_as_hash(Client.daily_leaders, root: :daily, options: { time_ago: 1.day.ago }),
            **LeaderboardBlueprinter.render_as_hash(Client.overall_leaders, root: :overall),
          }, status: 200
        )
      end

      def balance_history
        history = ExchangeTransaction.where('from_client_id = ? OR to_client_id = ?', params[:client_id], params[:client_id])

        render(
          json: {
            success: true,
            **::ExchangeTransactionBlueprinter.render_as_hash(history, root: :history),
          }, status: 200
        )
      end

      def colleagues
        client = Client.find(params[:client_id])
        teammates = client.team&.clients || []

        render(
          json: {
            success: true,
            **::UserBlueprinter.render_as_hash(teammates, root: :colleagues),
          }, status: 200
        )
      end

      private

      def resource
        Client
      end
    end
  end
end
