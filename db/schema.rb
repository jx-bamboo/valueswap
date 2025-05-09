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

ActiveRecord::Schema[8.0].define(version: 2025_04_14_081557) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.integer "network", null: false
    t.string "address", null: false
    t.string "pri_key_encrypted"
    t.integer "status", default: 0, null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address"], name: "index_addresses_on_address", unique: true
    t.index ["pri_key_encrypted"], name: "index_addresses_on_pri_key_encrypted", unique: true
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "airdrops", force: :cascade do |t|
    t.string "name"
    t.string "symbol"
    t.string "logo"
    t.string "intro"
    t.string "official_web"
    t.string "total_amount"
    t.string "reward_amount"
    t.string "network"
    t.string "tag"
    t.json "financing"
    t.string "eligibility"
    t.datetime "begin_time"
    t.datetime "end_time"
    t.integer "status"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_airdrops_on_user_id"
  end

  create_table "coins", force: :cascade do |t|
    t.string "symbol"
    t.string "name"
    t.string "quote_coin"
    t.string "logo"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_coins_on_name", unique: true
    t.index ["symbol"], name: "index_coins_on_symbol", unique: true
  end

  create_table "exchange_balances", force: :cascade do |t|
    t.decimal "spot", precision: 20, scale: 8, default: "0.0", null: false
    t.decimal "funding", precision: 20, scale: 8, default: "0.0", null: false
    t.decimal "usd_futures", precision: 20, scale: 8, default: "0.0", null: false
    t.json "ex_json", default: {}, null: false
    t.text "ex_text"
    t.integer "user_id", null: false
    t.integer "user_exchange_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_exchange_id"], name: "index_exchange_balances_on_user_exchange_id"
    t.index ["user_id"], name: "index_exchange_balances_on_user_id"
  end

  create_table "exchange_coins", force: :cascade do |t|
    t.integer "exchange_id", null: false
    t.integer "coin_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coin_id"], name: "index_exchange_coins_on_coin_id"
    t.index ["exchange_id"], name: "index_exchange_coins_on_exchange_id"
  end

  create_table "exchanges", force: :cascade do |t|
    t.string "name"
    t.string "logo"
    t.string "official_web"
    t.text "description"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_exchanges_on_name", unique: true
  end

  create_table "fund_purchases", force: :cascade do |t|
    t.decimal "quantity"
    t.decimal "price"
    t.decimal "total_amount"
    t.string "contract_hash"
    t.integer "user_id", null: false
    t.integer "fund_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fund_id"], name: "index_fund_purchases_on_fund_id"
    t.index ["user_id"], name: "index_fund_purchases_on_user_id"
  end

  create_table "funds", force: :cascade do |t|
    t.string "logo"
    t.string "name"
    t.decimal "price"
    t.integer "quantity"
    t.text "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "trade_type"
    t.string "status", default: "0", null: false
    t.string "official_web"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_funds_on_user_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.integer "invitee_id"
    t.string "invitation_code"
    t.integer "status", default: 0, null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_invitations_on_user_id"
  end

  create_table "operation_logs", force: :cascade do |t|
    t.string "operation_type"
    t.string "detail"
    t.string "ip"
    t.string "user_agent"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_operation_logs_on_user_id"
  end

  create_table "trades", force: :cascade do |t|
    t.string "trade_type", default: "manual", null: false
    t.string "side", null: false
    t.string "order_type", default: "limit", null: false
    t.decimal "price", precision: 15, scale: 8, null: false
    t.decimal "quantity", precision: 15, scale: 8, null: false
    t.decimal "fee", precision: 15, scale: 8, default: "0.0", null: false
    t.string "status", default: "pending", null: false
    t.decimal "profit_loss", precision: 15, scale: 8, default: "0.0"
    t.integer "leverage", default: 1
    t.string "position_side"
    t.string "order_id", null: false
    t.datetime "executed_at", null: false
    t.string "method"
    t.json "ex_json", default: {}, null: false
    t.text "ex_text"
    t.integer "user_id", null: false
    t.integer "exchange_id", null: false
    t.integer "user_exchange_id", null: false
    t.integer "coin_id"
    t.integer "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_trades_on_admin_id"
    t.index ["coin_id"], name: "index_trades_on_coin_id"
    t.index ["exchange_id"], name: "index_trades_on_exchange_id"
    t.index ["executed_at"], name: "index_trades_on_executed_at"
    t.index ["order_id"], name: "index_trades_on_order_id", unique: true
    t.index ["status"], name: "index_trades_on_status"
    t.index ["user_exchange_id"], name: "index_trades_on_user_exchange_id"
    t.index ["user_id"], name: "index_trades_on_user_id"
  end

  create_table "transfers", force: :cascade do |t|
    t.integer "transfer_type"
    t.string "network"
    t.string "txid"
    t.string "coin"
    t.decimal "amount"
    t.string "from_address"
    t.string "to_address"
    t.integer "status"
    t.datetime "confirmed_at"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["txid"], name: "index_transfers_on_txid", unique: true
    t.index ["user_id"], name: "index_transfers_on_user_id"
  end

  create_table "user_addresses", force: :cascade do |t|
    t.integer "network"
    t.string "w_address", null: false
    t.string "symbol"
    t.string "name"
    t.decimal "balance"
    t.integer "user_id", null: false
    t.integer "address_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_user_addresses_on_address_id"
    t.index ["user_id"], name: "index_user_addresses_on_user_id"
    t.index ["w_address"], name: "index_user_addresses_on_w_address", unique: true
  end

  create_table "user_exchange_coins", force: :cascade do |t|
    t.decimal "balance"
    t.datetime "last_updated"
    t.integer "status", default: 0, null: false
    t.integer "user_id", null: false
    t.integer "exchange_id", null: false
    t.integer "coin_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coin_id"], name: "index_user_exchange_coins_on_coin_id"
    t.index ["exchange_id"], name: "index_user_exchange_coins_on_exchange_id"
    t.index ["user_id"], name: "index_user_exchange_coins_on_user_id"
  end

  create_table "user_exchanges", force: :cascade do |t|
    t.string "api_key"
    t.string "api_secret"
    t.string "memo"
    t.integer "status", default: 0, null: false
    t.integer "user_id", null: false
    t.integer "exchange_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["api_key"], name: "index_user_exchanges_on_api_key", unique: true
    t.index ["api_secret"], name: "index_user_exchanges_on_api_secret", unique: true
    t.index ["exchange_id"], name: "index_user_exchanges_on_exchange_id"
    t.index ["user_id"], name: "index_user_exchanges_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "invite_code"
    t.string "phone"
    t.string "nickname"
    t.string "avatar"
    t.integer "role", default: 0, null: false
    t.integer "level"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invite_code"], name: "index_users_on_invite_code", unique: true
    t.index ["phone"], name: "index_users_on_phone", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "addresses", "users"
  add_foreign_key "airdrops", "users"
  add_foreign_key "exchange_balances", "user_exchanges"
  add_foreign_key "exchange_balances", "users"
  add_foreign_key "exchange_coins", "coins"
  add_foreign_key "exchange_coins", "exchanges"
  add_foreign_key "fund_purchases", "funds"
  add_foreign_key "fund_purchases", "users"
  add_foreign_key "funds", "users"
  add_foreign_key "invitations", "users"
  add_foreign_key "operation_logs", "users"
  add_foreign_key "trades", "coins"
  add_foreign_key "trades", "exchanges"
  add_foreign_key "trades", "user_exchanges"
  add_foreign_key "trades", "users"
  add_foreign_key "trades", "users", column: "admin_id"
  add_foreign_key "transfers", "users"
  add_foreign_key "user_addresses", "addresses"
  add_foreign_key "user_addresses", "users"
  add_foreign_key "user_exchange_coins", "coins"
  add_foreign_key "user_exchange_coins", "exchanges"
  add_foreign_key "user_exchange_coins", "users"
  add_foreign_key "user_exchanges", "exchanges"
  add_foreign_key "user_exchanges", "users"
end
