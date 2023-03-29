# frozen_string_literal: true

class ForumSearch < Searchlight::Search
  def base_query
    Forum.includes(:topic)
  end

  def search_title
    query.where('title LIKE ?', "#{options[:title]}%")
  end
end
