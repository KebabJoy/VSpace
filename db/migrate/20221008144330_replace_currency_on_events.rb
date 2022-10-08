class ReplaceCurrencyOnEvents < ActiveRecord::Migration[6.1]
  def change
    remove_column :events, :currency
    add_reference :events, :currency
  end
end
