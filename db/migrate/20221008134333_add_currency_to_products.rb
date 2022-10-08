class AddCurrencyToProducts < ActiveRecord::Migration[6.1]
  def change
    add_reference :products, :currency, index: true
    add_column :products, :category, :integer, default: 0, index: true
  end
end
