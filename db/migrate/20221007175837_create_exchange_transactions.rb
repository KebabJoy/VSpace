class CreateExchangeTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :exchange_transactions do |t|
      t.references :from_client, polymorphic: true
      t.references :to_client, polymorphic: true
      t.decimal :amount
      t.integer :currency

      t.timestamps
    end
  end
end
