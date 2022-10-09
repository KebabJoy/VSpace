class User < ApplicationRecord
  validates_presence_of :email, :password, :auth_token
  validates_uniqueness_of :email, :auth_token

  after_create :create_wallet

  def setup_token
    self.auth_token = SecureRandom.uuid
  end

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

  def has_enough_money?(price, currency)
    case currency.to_sym
    when :ruble
      matics.to_f >= ExchangeTransaction::MATIC_COMISSION && rubles.to_f >= price.to_f
    when :matic
      matics.to_f >= (price + ExchangeTransaction::MATIC_COMISSION).to_f
    else
      raise 'Invalid currency'
    end
  end

  private

  def create_wallet
    ::Wallet::Initializer.new(client: self).call
  end

  def sync_money
    @sync_money ||= Wallet::BalanceInfo.new(client: self).call
  end
end
