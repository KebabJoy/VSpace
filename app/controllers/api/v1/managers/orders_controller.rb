# frozen_string_literal: true

module Api
  module V1
    module Managers
      class OrdersController < BaseController
        def index
          currencies = Currency.all

          render(
            json: {
              success: true,
              **::CurrencyBlueprinter.render_as_hash(currencies, root: :currencies),
            }, status: 200
          )
        end

        private

        def resource
          Manager
        end
      end
    end
  end
end
