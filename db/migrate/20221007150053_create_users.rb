# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email,              null: false, default: ""
      t.string :first_name
      t.string :last_name
      t.integer :age
      t.text :bio
      t.string :type, null: false, default: 'Client'
      t.string :encrypted_password, null: false, default: ""
      t.string :auth_token, index: { unique: true }

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :type
  end
end
