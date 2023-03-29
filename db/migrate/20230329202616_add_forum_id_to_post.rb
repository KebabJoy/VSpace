class AddForumIdToPost < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!
  def change
    add_reference :forum_posts, :forum
  end
end
