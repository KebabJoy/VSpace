class CreateTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.belongs_to :leader

      t.timestamps
    end

    add_reference :users, :team, null: true, index: true
  end
end
