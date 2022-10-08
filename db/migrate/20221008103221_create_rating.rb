class CreateRating < ActiveRecord::Migration[6.1]
  def change
    create_table :ratings do |t|
      t.belongs_to :client
      t.decimal :score_change, default: 0

      t.timestamps
    end
  end
end
