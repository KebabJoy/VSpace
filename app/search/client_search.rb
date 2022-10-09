# frozen_string_literal: true

class ClientSearch < Searchlight::Search
  def base_query
    Client.includes(:ratings)
  end

  def search_team_id
    query.where(team_id: options[:team_id])
  end
end
