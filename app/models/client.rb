# frozen_string_literal: true

class Client < User
  # TODO: add redis cache on requests
  def matics
    sync_money
    read_attribute(:matics)
  end

  # TODO: add redis cache on requests
  def rubles
    sync_money

    read_attribute(:rubles)
  end

  def nft_balance
    Wallet::Nft::BalanceInfo.new(client: self).call
  end

  private

  def sync_money
    Wallet::BalanceInfo.new(client: self).call
  end
end
