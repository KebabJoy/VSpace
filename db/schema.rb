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

ActiveRecord::Schema.define(version: 2022_10_08_144330) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "currencies", force: :cascade do |t|
    t.integer "kind"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "deadline"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "reward", default: "0.0"
    t.integer "participants_needed", default: 0
    t.decimal "experience", default: "0.0"
    t.bigint "currency_id"
    t.index ["currency_id"], name: "index_events_on_currency_id"
  end

  create_table "exchange_transactions", force: :cascade do |t|
    t.string "from_client_type"
    t.bigint "from_client_id"
    t.string "to_client_type"
    t.bigint "to_client_id"
    t.decimal "amount"
    t.integer "currency"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "processed", default: false
    t.string "transaction_hash"
    t.index ["from_client_type", "from_client_id"], name: "index_exchange_transactions_on_from_client"
    t.index ["to_client_type", "to_client_id"], name: "index_exchange_transactions_on_to_client"
  end

  create_table "news", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.string "attachment_url", default: ""
    t.bigint "manager_id"
    t.integer "priority", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["manager_id"], name: "index_news_on_manager_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "client_id"
    t.bigint "product_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_orders_on_client_id"
    t.index ["product_id"], name: "index_orders_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "title"
    t.integer "amount"
    t.decimal "price"
    t.string "image_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "currency_id"
    t.integer "category", default: 0
    t.index ["currency_id"], name: "index_products_on_currency_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.bigint "client_id"
    t.decimal "score_change", default: "0.0"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_ratings_on_client_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.bigint "event_id"
    t.bigint "client_id"
    t.integer "state", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_tasks_on_client_id"
    t.index ["event_id"], name: "index_tasks_on_event_id"
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
    t.string "position", default: ""
    t.integer "rank", default: 0
    t.index ["auth_token"], name: "index_users_on_auth_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["type"], name: "index_users_on_type"
  end

end
