# frozen_string_literal: true

class Task < ApplicationRecord
  enum state: { in_progress: 0, for_review: 0, finished: 0, aborted: 0 }

  belongs_to :client
  belongs_to :event
end
