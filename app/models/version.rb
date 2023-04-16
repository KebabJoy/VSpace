# frozen_string_literal: true

class Version < ApplicationRecord
  serialize :object

  def object_as_json
    object.to_json
  end
end
