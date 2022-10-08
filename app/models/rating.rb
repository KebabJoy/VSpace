# frozen_string_literal: true

class Rating < ApplicationRecord
  belongs_to :client, class_name: 'Client'

  after_commit :set_rank!

  private

  def set_rank!
    sum = client.ratings.sum(:score_change)

    case
    when sum < 50
      client.newbie!
    when sum.in?(50..100)
      client.smesharik!
    when sum.in?(101..200)
      client.master!
    when sum > 200
      client.king!
    end
  end
end
