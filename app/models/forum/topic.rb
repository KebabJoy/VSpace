# frozen_string_literal: true

class Forum
  class Topic < ApplicationRecord
    has_many :forums, class_name: 'Forum', foreign_key: 'forum_topic_id'

    validates_presence_of :title, :description
  end
end