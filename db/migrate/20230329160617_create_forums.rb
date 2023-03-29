class CreateForums < ActiveRecord::Migration[6.1]
  def change
    create_table :forums do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.string :image_url
      t.integer :upvotes, default: 0
      t.integer :downvotes, default: 0
      t.belongs_to :creator, foreign_key: { to_table: :users }

      t.timestamps null: false
    end

    add_index :forums, :title, unique: true
  end
end
