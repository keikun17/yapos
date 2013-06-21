# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130607093706) do

  create_table "attachments", force: true do |t|
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.string   "document"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "emails"
    t.string   "contact_numbers"
    t.text     "address"
  end

  create_table "offers", force: true do |t|
    t.integer  "request_id"
    t.integer  "supplier_id"
    t.text     "specs"
    t.float    "buying_price"
    t.float    "selling_price"
    t.string   "currency"
    t.float    "currency_conversion"
    t.string   "order_reference"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "remarks"
    t.string   "terms"
    t.string   "delivery"
    t.string   "warranty"
    t.string   "price_vat_status"
    t.float    "total_buying_price"
    t.float    "total_selling_price"
    t.string   "price_basis"
    t.string   "summary"
  end

  add_index "offers", ["order_reference"], name: "index_offers_on_order_reference", using: :btree
  add_index "offers", ["summary"], name: "index_offers_on_summary", using: :btree

  create_table "orders", force: true do |t|
    t.string   "reference"
    t.datetime "purchase_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "custom_quote_reference"
    t.text     "description"
    t.integer  "supplier_id"
    t.integer  "client_id"
  end

  create_table "quotes", force: true do |t|
    t.datetime "quote_date"
    t.string   "quote_reference"
    t.float    "quantity"
    t.text     "description"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "client_id"
    t.integer  "supplier_id"
    t.integer  "order_id"
    t.string   "signatory"
    t.string   "signatory_position"
    t.string   "contact_person"
    t.text     "remarks"
    t.text     "internal_notes"
  end

  create_table "requests", force: true do |t|
    t.text     "specs"
    t.integer  "quote_id"
    t.integer  "supplier_id"
    t.text     "quoted_specifications"
    t.text     "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "quantity"
    t.string   "unit"
    t.integer  "client_purchased_count",     default: 0
    t.integer  "non_client_purchased_count", default: 0
  end

  create_table "supplier_orders", force: true do |t|
    t.integer  "offer_id"
    t.string   "reference"
    t.datetime "estimated_manufactured_at"
    t.datetime "manufactured_at"
    t.datetime "estimated_delivered_at"
    t.datetime "delivered_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "actual_specs"
  end

  create_table "supplier_purchases", force: true do |t|
    t.integer  "order_id"
    t.string   "reference"
    t.string   "recipient"
    t.string   "string"
    t.string   "address"
    t.text     "delivery"
    t.text     "price_basis"
    t.text     "remarks"
    t.text     "terms"
    t.text     "warranty"
    t.datetime "ordered_at"
    t.string   "signatory"
    t.string   "signatory_position"
  end

  add_index "supplier_purchases", ["order_id"], name: "index_supplier_purchases_on_order_id", using: :btree
  add_index "supplier_purchases", ["reference"], name: "index_supplier_purchases_on_reference", using: :btree

  create_table "suppliers", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "emails"
    t.string   "contact_numbers"
    t.text     "address"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
