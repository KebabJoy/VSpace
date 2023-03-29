# frozen_string_literal: true

module Api
  module V1
    class ForumsController < BaseController
      def index
        @forums = ForumSearch.new(forum_search_params).results.paginate(page: page, per_page: per_page)

        render json: {
          success: true,
          **::ForumBlueprinter.render_as_hash(@forums, root: :forums),
          page: page,
          per_page: per_page,
        }, status: 200
      end

      def topics
        @topics = Topic.paginate(page: page, per_page: per_page)

        render json: {
          success: true,
          **::TopicBlueprinter.render_as_hash(@topics, root: :topics),
          page: page,
          per_page: per_page,
        }, status: 200
      end

      private

      def forum_search_params
        params.permit(:title)
      end

      def resource
        Client
      end
    end
  end
end
