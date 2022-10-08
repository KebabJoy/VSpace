class AddPicsToClients < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :avatar_url, :string, default: ""
  end
end
