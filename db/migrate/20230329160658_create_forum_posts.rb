class CreateForumPosts < ActiveRecord::Migration[6.1]
  def change
    create_table :forum_posts do |t|
      t.belongs_to :creator, foreign_key: { to_table: :users }, null: false
      t.text :data, null: false

      t.timestamps
    end
  end
end
