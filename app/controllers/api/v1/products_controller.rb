# frozen_string_literal: true

module Api
  module V1
    class ProductsController < BaseController
      before_action :obtain_product, only: :buy

      def index
        products = ::ProductSearch.new(search_params).results

        render json: {
          success: true,
          **::ProductBlueprinter.render_as_hash(products, root: :products),
          count: products.size,
        }, status: 200
      end

      def buy
        response = ::Market::Purchase.new(product: @product, client: current_member).call

        if response.success?
          render(
            json: {
              success: true,
              **::ProductBlueprinter.render_as_hash(product),
            }
          )
        else
          render json: { success: false, message: response.failure }, status: 400
        end
      end

      def lottery
        
      end

      private

      def search_params
        params.permit(:category)
      end

      def obtain_product
        @product = Product.find(params[:id])
      end

      def resource
        Client
      end
    end
  end
end
