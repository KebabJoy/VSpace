# frozen_string_literal: true

class UserBlueprinter < Blueprinter::Base
  identifier :id
  fields :first_name, :last_name, :bio, :age, :auth_token
end
