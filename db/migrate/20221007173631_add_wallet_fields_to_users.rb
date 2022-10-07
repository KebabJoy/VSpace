class AddWalletFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :rubles, :decimal, default: 0
    add_column :users, :matics, :decimal, default: 0
    add_column :users, :private_key, :string, default: ''
    add_column :users, :public_key, :string, default: ''
  end
end
