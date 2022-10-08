# frozen_string_literal: true

class EventBlueprinter < Blueprinter::Base
  identifier :id
  fields :title, :description, :deadline, :currency, :reward
end
