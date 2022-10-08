class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.belongs_to :client
      t.belongs_to :product

      t.timestamps
    end
  end
end
