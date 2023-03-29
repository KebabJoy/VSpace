class AddReactionsTotalToPosts < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def up
    add_column :forum_posts, :upvotes, :integer, default: 0, algorithm: :concurrent
    add_column :forum_posts, :downvotes, :integer, default: 0, algorithm: :concurrent
  end

  def down
    remove_column :forum_posts, :upvotes
    remove_column :forum_posts, :downvotes
  end
end
