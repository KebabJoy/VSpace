# frozen_string_literal: true

class NewsBlueprinter < Blueprinter::Base
  identifier :id
  fields :title, :body, :attachment_url, :priority
end
