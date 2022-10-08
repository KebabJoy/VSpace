# frozen_string_literal: true

module Api
  module V1
    module Managers
      class ProductsController < BaseController
        def create
          product = Product.new(permitted_params)

          if product.save
            render(
              json: {
                success: true,
                **::ProductBlueprinter.render_as_hash(product),
              }, status: 200
            )
          else
            render json: { success: false, message: event.errors.full_message }, status: 400
          end
        end

        private

        def permitted_params
          params.permit(:title, :amount, :price, :image_url, :currency_id, :category)
        end

        def resource
          Manager
        end
      end
    end
  end
end
