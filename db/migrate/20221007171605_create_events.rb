class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :starts_at

      t.timestamps
    end
  end
end
