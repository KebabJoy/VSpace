class CreateNews < ActiveRecord::Migration[6.1]
  def change
    create_table :news do |t|
      t.string :title
      t.text :body
      t.string :attachment_url, default: ''
      t.belongs_to :manager
      t.integer :priority, default: 0

      t.timestamps
    end
  end
end
