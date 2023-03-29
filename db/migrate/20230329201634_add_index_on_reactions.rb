class AddIndexOnReactions < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    add_index :forum_posts, :upvotes, algorithm: :concurrently
    add_index :forum_posts, :downvotes, algorithm: :concurrently
    add_index :forums, :upvotes, algorithm: :concurrently
    add_index :forums, :downvotes, algorithm: :concurrently
  end
end
