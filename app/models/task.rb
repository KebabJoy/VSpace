# frozen_string_literal: true

class Task < ApplicationRecord
  enum state: { in_progress: 0, for_review: 0, finished: 0, aborted: 0 }

  belongs_to :client
  belongs_to :event

  def mark_finished!
    response = ::Wallet::Transactions::Processor.new(
      from_client_id: Admin::MONEY_STORAGE_ID,
      to_client_id: client_id,
      currency: event.currency,
      amount: event.reward,
    )

    finished! if response.success?
    response
  end
end
