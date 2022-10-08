# frozen_string_literal: true

module Api
  module V1
    class ProductsController < BaseController
      def index
        products = Product.order(price: :desc)

        render json: {
          success: true,
          **::ProductBlueprinter.render_as_hash(products, root: :products),
          count: products.size,
        }, status: 200
      end
    end
  end
end
