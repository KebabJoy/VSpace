class RenameStartsAtOnEvents < ActiveRecord::Migration[6.1]
  def change
    rename_column :events, :starts_at, :deadline
  end
end
