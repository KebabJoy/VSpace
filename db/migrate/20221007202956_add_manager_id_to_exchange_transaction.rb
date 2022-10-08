class AddManagerIdToExchangeTransaction < ActiveRecord::Migration[6.1]
  def change
    add_column :exchange_transactions, :processed, :boolean, default: false
    add_column :exchange_transactions, :transaction_hash, :string
  end
end
