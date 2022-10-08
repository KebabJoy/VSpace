# frozen_string_literal: true

class TaskBlueprinter < Blueprinter::Base
  identifier :id

  association :event, blueprint: EventBlueprinter
end
