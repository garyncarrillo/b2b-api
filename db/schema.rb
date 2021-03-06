# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_02_030752) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "articles", force: :cascade do |t|
    t.string "name"
    t.bigint "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_articles_on_category_id"
  end

  create_table "auctions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "state"
    t.text "description"
    t.string "contact_phone"
    t.string "place"
    t.integer "auction_type"
    t.text "terms_and_conditions"
    t.datetime "start_at"
    t.boolean "started", default: false
    t.integer "time_bit"
    t.string "uuid"
  end

  create_table "bids", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "product_id", null: false
    t.decimal "current_value", null: false
    t.decimal "value", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "auction_id", null: false
    t.index ["auction_id"], name: "index_bids_on_auction_id"
    t.index ["product_id"], name: "index_bids_on_product_id"
    t.index ["user_id"], name: "index_bids_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "customer_auctions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "auction_id", null: false
    t.boolean "paid", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "palette_number"
    t.string "ubication"
    t.index ["auction_id"], name: "index_customer_auctions_on_auction_id"
    t.index ["user_id"], name: "index_customer_auctions_on_user_id"
  end

  create_table "favourites", force: :cascade do |t|
    t.string "favouritable_type"
    t.bigint "favouritable_id"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_favourites_on_user_id"
  end

  create_table "jwt_blacklist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp"
    t.index ["jti"], name: "index_jwt_blacklist_on_jti"
  end

  create_table "on_site_users", force: :cascade do |t|
    t.string "number"
    t.string "first_name"
    t.string "last_name"
    t.string "company"
    t.string "phone"
    t.string "email"
    t.bigint "auction_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["auction_id"], name: "index_on_site_users_on_auction_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.decimal "initial_amount"
    t.decimal "bid_amount"
    t.bigint "article_id"
    t.bigint "auction_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "tax_included", default: false
    t.integer "currency", default: 0
    t.integer "quantity"
    t.integer "unit_of_measure", default: 0
    t.string "place_of_delivery"
    t.bigint "seller_id", null: false
    t.bigint "winner_id"
    t.string "state", default: "initial"
    t.index ["article_id"], name: "index_products_on_article_id"
    t.index ["auction_id"], name: "index_products_on_auction_id"
    t.index ["seller_id"], name: "index_products_on_seller_id"
  end

  create_table "sellers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["first_name", "last_name"], name: "index_sellers_on_first_name_and_last_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "company"
    t.string "phone"
    t.string "type"
    t.string "role", default: "customer"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.boolean "active", default: true
    t.string "uuid"
    t.string "identification_number"
    t.string "nick_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["identification_number"], name: "index_users_on_identification_number", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["nick_name"], name: "index_users_on_nick_name", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "articles", "categories"
  add_foreign_key "bids", "auctions"
  add_foreign_key "bids", "products"
  add_foreign_key "bids", "users"
  add_foreign_key "customer_auctions", "auctions"
  add_foreign_key "customer_auctions", "users"
  add_foreign_key "favourites", "users"
  add_foreign_key "on_site_users", "auctions"
  add_foreign_key "products", "auctions"
  add_foreign_key "products", "sellers"
  add_foreign_key "products", "users", column: "winner_id"
end
