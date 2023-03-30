# frozen_string_literal: true

class Forum
  class Topic < ApplicationRecord
    has_many :forums, class_name: 'Forum', foreign_key: 'forum_topics_id'

    validates_presence_of :title, :description
  end
end
