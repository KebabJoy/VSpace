class RenameClientsPassword < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :encrypted_password, :password
  end
end
