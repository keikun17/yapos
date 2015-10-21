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

ActiveRecord::Schema.define(version: 20151021145240) do

  create_table "attachments", force: :cascade do |t|
    t.integer  "attachable_id",   limit: 4
    t.string   "attachable_type", limit: 255
    t.string   "document",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "emails",            limit: 255
    t.string   "contact_numbers",   limit: 255
    t.text     "address",           limit: 65535
    t.string   "abbrev",            limit: 255
    t.integer  "parent_company_id", limit: 4
  end

  add_index "clients", ["parent_company_id"], name: "index_clients_on_parent_company_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "commentable_id",   limit: 4
    t.string   "commentable_type", limit: 255
    t.string   "title",            limit: 255
    t.text     "body",             limit: 65535
    t.string   "subject",          limit: 255
    t.integer  "user_id",          limit: 4,     null: false
    t.integer  "parent_id",        limit: 4
    t.integer  "lft",              limit: 4
    t.integer  "rgt",              limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "invoices", force: :cascade do |t|
    t.string   "reference",    limit: 255
    t.datetime "invoice_date"
    t.decimal  "amount",                   precision: 15, scale: 2
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  create_table "offers", force: :cascade do |t|
    t.integer  "request_id",                 limit: 4
    t.integer  "supplier_id",                limit: 4
    t.text     "specs",                      limit: 65535
    t.decimal  "buying_price",                             precision: 15, scale: 2
    t.decimal  "selling_price",                            precision: 15, scale: 2
    t.string   "currency",                   limit: 255
    t.float    "currency_conversion",        limit: 24
    t.string   "order_reference",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "remarks",                    limit: 65535
    t.string   "terms",                      limit: 255
    t.string   "delivery",                   limit: 255
    t.string   "warranty",                   limit: 255
    t.string   "price_vat_status",           limit: 255
    t.decimal  "total_buying_price",                       precision: 15, scale: 2
    t.decimal  "total_selling_price",                      precision: 15, scale: 2
    t.string   "price_basis",                limit: 255
    t.string   "summary",                    limit: 255
    t.string   "delivery_receipt_reference", limit: 255
    t.string   "sales_invoice_reference",    limit: 255
    t.string   "vendor_item_code",           limit: 255
    t.string   "vendor_item_id",             limit: 255
    t.boolean  "hide_supplier_in_print",     limit: 1
    t.text     "internal_notes",             limit: 65535
    t.string   "buying_currency",            limit: 255
    t.boolean  "service",                    limit: 1,                              default: false
  end

  add_index "offers", ["delivery_receipt_reference"], name: "index_offers_on_delivery_receipt_reference", using: :btree
  add_index "offers", ["order_reference"], name: "index_offers_on_order_reference", using: :btree
  add_index "offers", ["request_id"], name: "index_offers_on_request_id", using: :btree
  add_index "offers", ["sales_invoice_reference"], name: "index_offers_on_sales_invoice_reference", using: :btree
  add_index "offers", ["service"], name: "index_offers_on_service", using: :btree
  add_index "offers", ["summary"], name: "index_offers_on_summary", using: :btree
  add_index "offers", ["supplier_id"], name: "index_offers_on_supplier_id", using: :btree
  add_index "offers", ["vendor_item_code"], name: "index_offers_on_vendor_item_code", using: :btree
  add_index "offers", ["vendor_item_id"], name: "index_offers_on_vendor_item_id", using: :btree

  create_table "offers_invoices", force: :cascade do |t|
    t.integer "offer_id",   limit: 4
    t.integer "invoice_id", limit: 4
  end

  add_index "offers_invoices", ["invoice_id"], name: "index_offers_invoices_on_invoice_id", using: :btree
  add_index "offers_invoices", ["offer_id"], name: "index_offers_invoices_on_offer_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.string   "reference",              limit: 255
    t.datetime "purchase_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "custom_quote_reference", limit: 255
    t.text     "description",            limit: 65535
    t.integer  "supplier_id",            limit: 4
    t.integer  "client_id",              limit: 4
  end

  add_index "orders", ["reference"], name: "index_orders_on_reference", using: :btree

  create_table "parent_companies", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "payments", force: :cascade do |t|
    t.string   "reference",     limit: 255
    t.datetime "date_received"
    t.decimal  "amount",                    precision: 15, scale: 2
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  create_table "payments_invoices", force: :cascade do |t|
    t.integer "invoice_id", limit: 4
    t.integer "payment_id", limit: 4
  end

  add_index "payments_invoices", ["invoice_id"], name: "index_payments_invoices_on_invoice_id", using: :btree
  add_index "payments_invoices", ["payment_id"], name: "index_payments_invoices_on_payment_id", using: :btree

  create_table "product_fields", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "unit",       limit: 255
    t.integer  "product_id", limit: 4
    t.string   "field_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_fields", ["product_id"], name: "index_product_fields_on_product_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quotes", force: :cascade do |t|
    t.datetime "quote_date"
    t.string   "quote_reference",    limit: 255
    t.float    "quantity",           limit: 24
    t.text     "description",        limit: 65535
    t.string   "status",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "client_id",          limit: 4
    t.integer  "supplier_id",        limit: 4
    t.integer  "order_id",           limit: 4
    t.string   "signatory",          limit: 255
    t.string   "signatory_position", limit: 255
    t.string   "contact_person",     limit: 255
    t.text     "remarks",            limit: 65535
    t.text     "internal_notes",     limit: 65535
    t.text     "title",              limit: 65535
    t.text     "blurb",              limit: 65535
  end

  add_index "quotes", ["client_id"], name: "index_quotes_on_client_id", using: :btree
  add_index "quotes", ["quote_date"], name: "index_quotes_on_quote_date", using: :btree
  add_index "quotes", ["quote_reference"], name: "index_quotes_on_quote_reference", using: :btree

  create_table "requests", force: :cascade do |t|
    t.text     "specs",                      limit: 65535
    t.integer  "quote_id",                   limit: 4
    t.integer  "supplier_id",                limit: 4
    t.text     "quoted_specifications",      limit: 65535
    t.text     "remarks",                    limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "quantity",                   limit: 24
    t.string   "unit",                       limit: 255
    t.integer  "client_purchased_count",     limit: 4,     default: 0
    t.integer  "non_client_purchased_count", limit: 4,     default: 0
    t.integer  "position",                   limit: 4
    t.string   "item_code",                  limit: 255
  end

  add_index "requests", ["item_code"], name: "index_requests_on_item_code", using: :btree
  add_index "requests", ["quote_id"], name: "index_requests_on_quote_id", using: :btree

  create_table "stocks", force: :cascade do |t|
    t.float    "remaining_quantity", limit: 24
    t.string   "reference",          limit: 255
    t.string   "unit",               limit: 255
    t.integer  "supplier_id",        limit: 4
    t.text     "description",        limit: 65535
    t.text     "remarks",            limit: 65535
    t.datetime "date_acquired"
    t.datetime "date_used_up"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "initial_quantity",   limit: 24
  end

  create_table "supplier_orders", force: :cascade do |t|
    t.integer  "offer_id",                  limit: 4
    t.string   "reference",                 limit: 255
    t.datetime "estimated_manufactured_at"
    t.datetime "estimated_delivered_at"
    t.datetime "delivered_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "actual_specs",              limit: 65535
  end

  add_index "supplier_orders", ["offer_id"], name: "index_supplier_orders_on_offer_id", using: :btree
  add_index "supplier_orders", ["reference"], name: "index_supplier_orders_on_reference", using: :btree

  create_table "supplier_purchases", force: :cascade do |t|
    t.integer  "order_id",             limit: 4
    t.string   "reference",            limit: 255
    t.string   "recipient",            limit: 255
    t.string   "string",               limit: 255
    t.string   "address",              limit: 255
    t.text     "delivery",             limit: 65535
    t.text     "price_basis",          limit: 65535
    t.text     "remarks",              limit: 65535
    t.text     "terms",                limit: 65535
    t.text     "warranty",             limit: 65535
    t.datetime "ordered_at"
    t.string   "signatory",            limit: 255
    t.string   "signatory_position",   limit: 255
    t.boolean  "hide_client_in_print", limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "supplier_purchases", ["order_id"], name: "index_supplier_purchases_on_order_id", using: :btree
  add_index "supplier_purchases", ["reference"], name: "index_supplier_purchases_on_reference", using: :btree

  create_table "suppliers", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "emails",          limit: 255
    t.string   "contact_numbers", limit: 255
    t.text     "address",         limit: 65535
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vendor_item_fields", force: :cascade do |t|
    t.integer  "vendor_item_id",   limit: 4
    t.string   "value",            limit: 255
    t.integer  "product_field_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "vendor_item_fields", ["product_field_id"], name: "index_vendor_item_fields_on_product_field_id", using: :btree
  add_index "vendor_item_fields", ["vendor_item_id"], name: "index_vendor_item_fields_on_vendor_item_id", using: :btree

  create_table "vendor_items", force: :cascade do |t|
    t.string   "code",       limit: 255
    t.integer  "product_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "vendor_items", ["product_id"], name: "index_vendor_items_on_product_id", using: :btree

end
