class CreateReactions < ActiveRecord::Migration[6.1]
  def change
    create_table :reactions do |t|
      t.belongs_to :client, null: false
      t.belongs_to :ratable, polymorphic: true
      t.integer :value, null: false

      t.timestamps
    end
  end
end
