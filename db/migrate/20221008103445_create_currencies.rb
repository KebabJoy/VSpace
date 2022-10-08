class CreateCurrencies < ActiveRecord::Migration[6.1]
  def change
    create_table :currencies do |t|
      t.integer :kind
      
      t.timestamps
    end
  end
end
