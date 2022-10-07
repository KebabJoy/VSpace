class CreateExchangeTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :exchange_transactions do |t|
      t.belongs_to :from_client
      t.belongs_to :to_client
      t.decimal :amount
      t.integer :currency

      t.timestamps
    end
  end
end
