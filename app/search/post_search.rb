# frozen_string_literal: true

class PostSearch < Searchlight::Search
  def base_query
    Forum::Post.includes(:creator)
  end

  def search_forum_id
    query.where(forum_id: options[:forum_id])
  end
end
