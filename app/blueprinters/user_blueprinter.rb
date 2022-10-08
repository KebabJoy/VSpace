# frozen_string_literal: true

class UserBlueprinter < Blueprinter::Base
  identifier :id
  fields :first_name, :last_name, :bio, :age, :auth_token, :position

  field :rubles, if: ->(_f, user, _o) { user.is_a?(Client) }
  field :matics, if: ->(_f, user, _o) { user.is_a?(Client) }
  field :nft_balance, if: ->(_f, user, _o) { user.is_a?(Client) }
  field :rank, if: ->(_f, user, _o) { user.is_a?(Client) }
  field :city, if: ->(_f, user, _o) { user.is_a?(Client) }
  field :rank_before_type_cast, name: :rank_number, if: -> (_f, user, _o) { user.is_a?(Client) }

  field(:experience) do |user, _o|
    user.ratings.sum(:score_change)
  end

  field(:team) do |user, _o|
    user.team&.name.to_s
  end
end
