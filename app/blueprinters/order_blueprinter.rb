# frozen_string_literal: true

class OrderBlueprinter < Blueprinter::Base
  identifier :id

  association :product, blueprint: ProductBlueprinter
end
