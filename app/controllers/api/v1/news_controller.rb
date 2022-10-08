# frozen_string_literal: true

module Api
  module V1
    class NewsController < BaseController
      def index
        news = News.order(priority: :desc, created_at: :desc)

        render(
          json: {
            success: true,
            **::NewsBlueprinter.render_as_hash(news, root: :news),
            count: news.size,
          }, status: 200
        )
      end

      private

      def filter_params

      end
    end
  end
end
