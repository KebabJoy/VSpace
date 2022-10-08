# frozen_string_literal: true

module Api
  module V1
    module Managers
      class CurrenciesController < BaseController
        def index
          render(
            json: {
              success: true,
              **::CurrencyBlueprinter.render_as_hash(Currency.all, root: :currencies),
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
