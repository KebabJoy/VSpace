class ReplaceCurrencyOnTransactions < ActiveRecord::Migration[6.1]
  def change
    remove_column :exchange_transactions, :currency
    add_reference :exchange_transactions, :currency
  end
end
