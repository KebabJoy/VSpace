class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  after_touch :reindex_data

  def self.searchable?
    defined?(self.solr_search) == 'method'
  end

  private

  def reindex_data
    self.index if self.class.searchable?
  end
end
