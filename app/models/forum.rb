# frozen_string_literal: true
# create_table :forums do |t|
#   t.string :title, null: false
#   t.text :description, null: false
#   t.string :image_url
#   t.integer :upvotes, default: 0
#   t.integer :downvotes, default: 0
#   t.belongs_to :creator, foreign_key: { to_table: :users }
#
#   t.timestamps null: false
# end
class Forum < ApplicationRecord
  belongs_to :creator, class_name: 'Client'
  belongs_to :topic, class_name: 'Forum::Topic', foreign_key: 'forum_topics_id'

  has_many :upvote_reactions, -> { upvote }, class_name: 'Forum::Reaction', as: :ratable
  has_many :downvote_reactions, -> { downvote }, class_name: 'Forum::Reaction', as: :ratable

  validates_presence_of :title, :description, :creator, :topic

  searchable do
    text(:title, as: :title_fz)
    text(:description, as: :description_fz)
  end
end
