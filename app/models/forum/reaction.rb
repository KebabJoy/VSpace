# frozen_string_literal: true

class Forum
  class Reaction < ApplicationRecord
    self.table_name = 'reactions'

    belongs_to :ratable, polymorphic: true
    belongs_to :client

    scope :upvote, -> { where(value: 1) }
    scope :downvote, -> { where(value: -1) }

    validates_presence_of :ratable, :client, :value
    validates :value, inclusion: { in: (-1..1) }

    after_commit :update_ratable

    private

    def update_ratable
      ratable.update!(upvotes: ratable.upvote_reactions.count, downvotes: ratable.downvote_reactions.count)
    end
  end
end
