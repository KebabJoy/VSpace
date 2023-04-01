# frozen_string_literal: true

module Api
  module V1
    module Managers
      class NewsController < BaseController
        def create
          news = News.new(permitted_params)

          if news.save
            render(
              json: {
                success: true,
                **::NewsBlueprinter.render_as_hash(news, root: :news)
              }
            )
          else
            render json: { success: false, message: news.errors.full_messages }, status: 400
          end
        end

        private

        def permitted_params
          params.require(:news).permit(:title, :body, :priority, :attachment_url)
        end

        def resource
          Manager
        end
      end
    end
  end
end
