# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_10_07_202956) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "starts_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "exchange_transactions", force: :cascade do |t|
    t.bigint "from_client_id"
    t.bigint "to_client_id"
    t.decimal "amount"
    t.integer "currency"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "managers_id"
    t.boolean "processed", default: false
    t.string "transaction_hash"
    t.index ["from_client_id"], name: "index_exchange_transactions_on_from_client_id"
    t.index ["managers_id"], name: "index_exchange_transactions_on_managers_id"
    t.index ["to_client_id"], name: "index_exchange_transactions_on_to_client_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "title"
    t.integer "amount"
    t.decimal "price"
    t.string "image_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.integer "age"
    t.text "bio"
    t.string "type", default: "Client", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "auth_token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "rubles", default: "0.0"
    t.decimal "matics", default: "0.0"
    t.string "private_key", default: ""
    t.string "public_key", default: ""
    t.index ["auth_token"], name: "index_users_on_auth_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["type"], name: "index_users_on_type"
  end

end
