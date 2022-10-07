# frozen_string_literal: true

class UserBlueprinter < Blueprinter::Base
  identifier :id
  fields :first_name, :last_name, :bio, :age, :auth_token

  field :rubles, if: ->(_f, user, _o) { user.is_a?(Client) }
  field :matics, if: ->(_f, user, _o) { user.is_a?(Client) }
  field :nft_balance, if: ->(_f, user, _o) { user.is_a?(Client) }
end
