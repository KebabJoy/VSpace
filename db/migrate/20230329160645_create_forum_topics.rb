class CreateForumTopics < ActiveRecord::Migration[6.1]
  def change
    create_table :forum_topics do |t|
      t.string :title, null: false
      t.text :description, null: false

      t.timestamps
    end

    add_reference :forums, :forum_topics, index: true
  end
end
