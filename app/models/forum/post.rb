# frozen_string_literal: true

class Forum
  class Post < ApplicationRecord
    belongs_to :creator, class_name: 'Client'
    belongs_to :forum

    has_many :upvote_reactions, -> { upvote }, class_name: 'Forum::Reaction', as: :ratable
    has_many :downvote_reactions, -> { downvote }, class_name: 'Forum::Reaction', as: :ratable

    validates_presence_of :data, :forum
  end
end
