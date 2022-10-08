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

  private

  def create_wallet
    ::Wallet::Initializer.new(client: self).call
  end
end
