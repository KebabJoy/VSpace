# frozen_string_literal: true

class LeaderboardBlueprinter < Blueprinter::Base
  fields :id, :first_name, :last_name

  field(:score) do |obj, opts|
    if opts[:time_ago]
      obj.ratings.where('created_at > ?', opts[:time_ago]).sum(:score_change)
    else
      obj.ratings.sum(:score_change)
    end
  end
end
