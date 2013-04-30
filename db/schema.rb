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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130430153556) do

  create_table "attachments", :force => true do |t|
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.string   "document"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "emails"
    t.string   "contact_numbers"
    t.text     "address"
  end

  create_table "offers", :force => true do |t|
    t.integer  "request_id"
    t.integer  "supplier_id"
    t.text     "specs"
    t.float    "buying_price"
    t.float    "selling_price"
    t.string   "currency"
    t.float    "currency_conversion"
    t.string   "order_reference"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.text     "remarks"
    t.string   "terms"
    t.string   "delivery"
    t.string   "warranty"
    t.string   "price_vat_status"
  end

  add_index "offers", ["order_reference"], :name => "index_offers_on_order_reference"

  create_table "orders", :force => true do |t|
    t.string   "reference"
    t.datetime "purchase_date"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "custom_quote_reference"
    t.text     "description"
    t.integer  "supplier_id"
    t.integer  "client_id"
  end

  create_table "quotes", :force => true do |t|
    t.datetime "quote_date"
    t.string   "quote_reference"
    t.float    "quantity"
    t.text     "description"
    t.string   "status"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "client_id"
    t.integer  "supplier_id"
    t.integer  "order_id"
    t.string   "signatory"
    t.string   "signatory_position"
    t.string   "contact_person"
  end

  create_table "requests", :force => true do |t|
    t.text     "specs"
    t.integer  "quote_id"
    t.integer  "supplier_id"
    t.text     "quoted_specifications"
    t.text     "remarks"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.float    "quantity"
    t.string   "unit"
  end

  create_table "supplier_orders", :force => true do |t|
    t.integer  "offer_id"
    t.string   "reference"
    t.datetime "ordered_at"
    t.datetime "estimated_manufactured_at"
    t.datetime "manufactured_at"
    t.datetime "estimated_delivered_at"
    t.datetime "delivered_at"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "suppliers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "emails"
    t.string   "contact_numbers"
    t.text     "address"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
