# frozen_string_literal: true

class Client < User
  enum rank: { newbie: 0, smesharik: 1, master: 2, king: 3 }

  scope :monthly_leaders, -> do
    joins(:ratings).where('ratings.created_at > ?', 1.month.ago).group('users.id').order('SUM(ratings.score_change) DESC')
  end

  scope :daily_leaders, -> do
    joins(:ratings).where('ratings.created_at > ?', 1.day.ago).group('users.id').order('SUM(ratings.score_change) DESC')
  end

  scope :overall_leaders, -> do
    joins(:ratings).group('users.id').order('SUM(ratings.score_change) DESC')
  end

  has_many :transfer_transactions, class_name: 'ExchangeTransaction', foreign_key: 'from_client_id'
  has_many :topup_transactions, class_name: 'ExchangeTransaction', foreign_key: 'to_client_id'

  has_many :ratings

  def rank
    I18n.t("client.rank.#{read_attribute(:rank)}")
  end

  def nft_balance
    @nft_balance ||= Wallet::Nft::BalanceInfo.new(client: self).call
  end

  private

  def sync_money
    @sync_money ||= Wallet::BalanceInfo.new(client: self).call
  end
end
