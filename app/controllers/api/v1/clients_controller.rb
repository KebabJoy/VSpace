# frozen_string_literal: true

module Api
  module V1
    class ClientsController < BaseController
      include Authable

      after_action :create_wallet, only: :create

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

      end

      private

      def create_wallet
        ::Wallet::Initializer.new(client: @current_member).call if @current_member.persisted?
      end

      def resource
        Client
      end
    end
  end
end
