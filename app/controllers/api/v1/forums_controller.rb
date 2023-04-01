# frozen_string_literal: true

module Api
  module V1
    class ForumsController < BaseController
      def index
        @forums = Rails.cache.fetch("forum:index:#{cache_key}") do
          Forum.solr_search do |snp|
            snp.fulltext(params[:query])
            snp.paginate page: page, per_page: per_page
          end.results
        end

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

      def resource
        Client
      end

      def cache_key
        key =
          {
            query: params[:query],
            page: page,
            per_page: per_page,
          }.sort.map do |modifier, value|
            "#{modifier}:#{value}"
          end.join('::').downcase

        Digest::MD5.hexdigest(key)
      end
    end
  end
end
