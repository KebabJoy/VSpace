class AddCategoryToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :category, :integer, default: 0
  end
end
