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

ActiveRecord::Schema.define(version: 20150218123826) do

  create_table "attachments", force: true do |t|
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.string   "document"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "clients", force: true do |t|
    t.string   "name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "emails"
    t.string   "contact_numbers"
    t.text     "address"
    t.string   "abbrev"
  end

  create_table "offers", force: true do |t|
    t.integer  "request_id"
    t.integer  "supplier_id"
    t.text     "specs"
    t.float    "buying_price",               limit: 24
    t.float    "selling_price",              limit: 24
    t.string   "currency"
    t.float    "currency_conversion",        limit: 24
    t.string   "order_reference"
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.text     "remarks"
    t.string   "terms"
    t.string   "delivery"
    t.string   "warranty"
    t.string   "price_vat_status"
    t.float    "total_buying_price",         limit: 24
    t.float    "total_selling_price",        limit: 24
    t.string   "price_basis"
    t.string   "summary"
    t.string   "delivery_receipt_reference"
    t.string   "sales_invoice_reference"
    t.string   "vendor_item_code"
    t.string   "vendor_item_id"
    t.boolean  "hide_supplier_in_print"
    t.text     "internal_notes"
    t.string   "buying_currency"
    t.boolean  "service",                               default: false
  end

  add_index "offers", ["delivery_receipt_reference"], name: "index_offers_on_delivery_receipt_reference", using: :btree
  add_index "offers", ["order_reference"], name: "index_offers_on_order_reference", using: :btree
  add_index "offers", ["sales_invoice_reference"], name: "index_offers_on_sales_invoice_reference", using: :btree
  add_index "offers", ["service"], name: "index_offers_on_service", using: :btree
  add_index "offers", ["summary"], name: "index_offers_on_summary", using: :btree
  add_index "offers", ["vendor_item_code"], name: "index_offers_on_vendor_item_code", using: :btree
  add_index "offers", ["vendor_item_id"], name: "index_offers_on_vendor_item_id", using: :btree

  create_table "orders", force: true do |t|
    t.string   "reference"
    t.datetime "purchase_date"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "custom_quote_reference"
    t.text     "description"
    t.integer  "supplier_id"
    t.integer  "client_id"
  end

  create_table "product_fields", force: true do |t|
    t.string   "name"
    t.string   "unit"
    t.integer  "product_id"
    t.string   "field_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_fields", ["product_id"], name: "index_product_fields_on_product_id", using: :btree

  create_table "products", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quotes", force: true do |t|
    t.datetime "quote_date"
    t.string   "quote_reference"
    t.float    "quantity",           limit: 24
    t.text     "description"
    t.string   "status"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "client_id"
    t.integer  "supplier_id"
    t.integer  "order_id"
    t.string   "signatory"
    t.string   "signatory_position"
    t.string   "contact_person"
    t.text     "remarks"
    t.text     "internal_notes"
    t.text     "title"
    t.text     "blurb"
  end

  add_index "quotes", ["quote_date"], name: "index_quotes_on_quote_date", using: :btree

  create_table "requests", force: true do |t|
    t.text     "specs"
    t.integer  "quote_id"
    t.integer  "supplier_id"
    t.text     "quoted_specifications"
    t.text     "remarks"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.float    "quantity",                   limit: 24
    t.string   "unit"
    t.integer  "client_purchased_count",                default: 0
    t.integer  "non_client_purchased_count",            default: 0
    t.integer  "position"
    t.string   "item_code"
  end

  add_index "requests", ["item_code"], name: "index_requests_on_item_code", using: :btree

  create_table "stocks", force: true do |t|
    t.float    "remaining_quantity", limit: 24
    t.string   "reference"
    t.string   "unit"
    t.integer  "supplier_id"
    t.text     "description"
    t.text     "remarks"
    t.datetime "date_acquired"
    t.datetime "date_used_up"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "initial_quantity",   limit: 24
  end

  create_table "supplier_orders", force: true do |t|
    t.integer  "offer_id"
    t.string   "reference"
    t.datetime "estimated_manufactured_at"
    t.datetime "estimated_delivered_at"
    t.datetime "delivered_at"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
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
    t.boolean  "hide_client_in_print"
  end

  add_index "supplier_purchases", ["order_id"], name: "index_supplier_purchases_on_order_id", using: :btree
  add_index "supplier_purchases", ["reference"], name: "index_supplier_purchases_on_reference", using: :btree

  create_table "suppliers", force: true do |t|
    t.string   "name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vendor_item_fields", force: true do |t|
    t.integer  "vendor_item_id"
    t.string   "value"
    t.integer  "product_field_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "vendor_item_fields", ["product_field_id"], name: "index_vendor_item_fields_on_product_field_id", using: :btree
  add_index "vendor_item_fields", ["vendor_item_id"], name: "index_vendor_item_fields_on_vendor_item_id", using: :btree

  create_table "vendor_items", force: true do |t|
    t.string   "code"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "vendor_items", ["product_id"], name: "index_vendor_items_on_product_id", using: :btree

end
