# frozen_string_literal: true

class ProductSearch < Searchlight::Search
  def base_query
    Product.all
  end

  def search_category
    query.where(category: options[:category])
  end
end
