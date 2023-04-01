# frozen_string_literal: true

module Api
  module V1
    class PostsController < BaseController
      def index
        posts = Rails.cache.fetch("forum:posts:index:#{cache_key}") do
          Forum::Post.solr_search do |snp|
            snp.fulltext(filter_params[:query])
            snp.with(:forum_id, filter_params[:forum_id])
            snp.paginate page: page, per_page: per_page
          end.results
        end

        render json: {
          success: true,
          **::PostBlueprinter.render_as_hash(posts, root: :posts, client: current_member),
          page: page,
          per_page: per_page,
        }, status: 200
      end

      def create
        post = Forum::Post.new(forum_id: params[:forum_id], creator: current_member, data: params[:message])

        if post.save
          render json: {
            success: true,
            **::PostBlueprinter.render_as_hash(post, root: :post, client: current_member),
          }, status: 200
        else
          render json: {
            success: false,
            message: post.errors.full_messages,
          }, status: 400
        end
      end

      private

      def resource
        Client
      end

      def filter_params
        params.permit(:query, :forum_id)
      end

      def cache_key
        key =
          {
            query: filter_params[:query],
            page: page,
            per_page: per_page,
            forum_id: filter_params[:forum_id],
          }.sort.map do |modifier, value|
            "#{modifier}:#{value}"
          end.join('::').downcase

        Digest::MD5.hexdigest(key)
      end
    end
  end
end
