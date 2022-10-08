class AddExpToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :experience, :decimal, default: 0
  end
end
