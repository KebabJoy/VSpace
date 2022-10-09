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
              **::ProductBlueprinter.render_as_hash(@product),
            }
          )
        else
          render json: { success: false, message: response.failure }, status: 400
        end
      end

      def lottery
        lower_bound = current_member.matic - ExchangeTransaction::MATIC_COMISSION
        product_ids = Product
                      .joins(:currency)
                      .where(
                        '(currencies.kind = ? AND products.price < ?) OR (currencies.kind = ? AND products.price < ?)',
                        Currency.kinds[:ruble], current_member.rubles, Currency.kinds[:matic], lower_bound
                        ).pluck(:id)

        @product = Product.find_by(id: product_ids.sample)
        response = ::Market::Purchase.new(product: @product, client: current_member).call if @product

        if response&.success?
          render(
            json: {
              success: true,
              **::ProductBlueprinter.render_as_hash(@product),
            }
          )
        else
          render json: { success: false, message: 'Недостаточно денег ни на один товар' }, status: 404
        end
      end

      private

      def search_params
        params.permit(:category)
      end

      def obtain_product
        @product = Product.find(params[:product_id])
      end

      def resource
        Client
      end
    end
  end
end
