class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.belongs_to :event
      t.belongs_to :client
      t.integer :state, default: 0

      t.timestamps
    end
  end
end
