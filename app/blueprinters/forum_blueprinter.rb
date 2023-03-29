# frozen_string_literal: true

class ForumBlueprinter < Blueprinter::Base
  identifier :id
  fields :title, :description, :creator_id, :upvotes, :downvotes

  field(:topic) do |obj, _|
    obj.topic.title
  end
end
