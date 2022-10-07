class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :title
      t.integer :amount
      t.decimal :price
      t.string :image_url

      t.timestamps
    end
  end
end
