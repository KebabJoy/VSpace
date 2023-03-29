# frozen_string_literal: true

module Api
  module V1
    class PostsController < BaseController
      def index
        posts = PostSearch.new(filter_params).results.paginate(page: page, per_page: per_page)

        render json: {
          success: true,
          **::PostBlueprinter.render_as_hash(posts, root: :posts),
          page: page,
          per_page: per_page,
        }, status: 200
      end

      def create
        post = Forum::Post.new(forum_id: params[:forum_id], creator: current_member, data: params[:data])

        if post.save
          render json: {
            success: true,
            **::PostBlueprinter.render_as_hash(post),
          }, status: 200
        else
          render json: {
            success: false,
            message: post.errors.full_message,
          }, status: 400
        end
      end

      private

      def resource
        Client
      end

      def filter_params
        params.permit(:forum_id)
      end
    end
  end
end
