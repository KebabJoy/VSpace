class AddDefaultValueToReactions < ActiveRecord::Migration[6.1]
  def change
    change_column_default :reactions, :value, 0
  end
end
