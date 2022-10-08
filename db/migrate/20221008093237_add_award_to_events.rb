class AddAwardToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :reward, :decimal, default: 0
    add_column :events, :currency, :integer, default: 0
    add_column :events, :participants_needed, :integer, default: 0
  end
end
