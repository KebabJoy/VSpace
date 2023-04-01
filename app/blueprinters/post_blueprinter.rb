# frozen_string_literal: true

class PostBlueprinter < Blueprinter::Base
  identifier :id
  fields :data, :upvotes, :downvotes

  field(:creator_fullname) do |obj, _o|
    obj.creator.first_name + ' ' + obj.creator.last_name
  end

  field(:reaction) do |obj, opts|
    opts[:client].reactions.find_by(ratable: obj)&.value.to_i
  end
end
