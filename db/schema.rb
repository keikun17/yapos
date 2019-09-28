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

ActiveRecord::Schema.define(version: 2019_09_27_152853) do

  create_table "attachments", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "attachable_id"
    t.string "attachable_type"
    t.string "document"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "emails"
    t.string "contact_numbers"
    t.text "address"
    t.string "abbrev"
    t.integer "parent_company_id"
    t.index ["parent_company_id"], name: "index_clients_on_parent_company_id"
  end

  create_table "comments", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "commentable_id"
    t.string "commentable_type"
    t.string "title"
    t.text "body"
    t.string "subject"
    t.integer "user_id", null: false
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "invoices", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "reference"
    t.datetime "invoice_date"
    t.decimal "amount", precision: 15, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "offers", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "request_id"
    t.integer "supplier_id"
    t.text "specs"
    t.decimal "buying_price", precision: 15, scale: 2
    t.decimal "selling_price", precision: 15, scale: 2
    t.string "currency"
    t.float "currency_conversion"
    t.string "order_reference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "remarks"
    t.string "terms"
    t.string "delivery"
    t.string "warranty"
    t.string "price_vat_status"
    t.decimal "total_buying_price", precision: 15, scale: 2
    t.decimal "total_selling_price", precision: 15, scale: 2
    t.string "price_basis"
    t.string "summary"
    t.string "delivery_receipt_reference"
    t.string "sales_invoice_reference"
    t.string "vendor_item_code"
    t.string "vendor_item_id"
    t.boolean "hide_supplier_in_print"
    t.text "internal_notes"
    t.string "buying_currency"
    t.boolean "service", default: false
    t.boolean "from_stock", default: false
    t.index ["delivery_receipt_reference"], name: "index_offers_on_delivery_receipt_reference"
    t.index ["order_reference"], name: "index_offers_on_order_reference"
    t.index ["request_id"], name: "index_offers_on_request_id"
    t.index ["sales_invoice_reference"], name: "index_offers_on_sales_invoice_reference"
    t.index ["service"], name: "index_offers_on_service"
    t.index ["summary"], name: "index_offers_on_summary"
    t.index ["supplier_id"], name: "index_offers_on_supplier_id"
    t.index ["vendor_item_code"], name: "index_offers_on_vendor_item_code"
    t.index ["vendor_item_id"], name: "index_offers_on_vendor_item_id"
  end

  create_table "offers_invoices", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "offer_id"
    t.integer "invoice_id"
    t.index ["invoice_id"], name: "index_offers_invoices_on_invoice_id"
    t.index ["offer_id"], name: "index_offers_invoices_on_offer_id"
  end

  create_table "orders", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "reference"
    t.datetime "purchase_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "custom_quote_reference"
    t.text "description"
    t.integer "supplier_id"
    t.integer "client_id"
    t.index ["reference"], name: "index_orders_on_reference"
  end

  create_table "parent_companies", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
  end

  create_table "payments", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "reference"
    t.datetime "date_received"
    t.decimal "amount", precision: 15, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments_invoices", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "invoice_id"
    t.integer "payment_id"
    t.index ["invoice_id"], name: "index_payments_invoices_on_invoice_id"
    t.index ["payment_id"], name: "index_payments_invoices_on_payment_id"
  end

  create_table "product_fields", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.string "unit"
    t.integer "product_id"
    t.string "field_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["product_id"], name: "index_product_fields_on_product_id"
  end

  create_table "products", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quotes", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.datetime "quote_date"
    t.string "quote_reference"
    t.float "quantity"
    t.text "description"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "client_id"
    t.integer "supplier_id"
    t.integer "order_id"
    t.string "signatory"
    t.string "signatory_position"
    t.string "contact_person"
    t.text "remarks"
    t.text "internal_notes"
    t.text "title"
    t.text "blurb"
    t.index ["client_id"], name: "index_quotes_on_client_id"
    t.index ["quote_date"], name: "index_quotes_on_quote_date"
    t.index ["quote_reference"], name: "index_quotes_on_quote_reference"
  end

  create_table "requests", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.text "specs"
    t.integer "quote_id"
    t.integer "supplier_id"
    t.text "quoted_specifications"
    t.text "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "quantity"
    t.string "unit"
    t.integer "client_purchased_count", default: 0
    t.integer "non_client_purchased_count", default: 0
    t.integer "position"
    t.string "item_code"
    t.index ["item_code"], name: "index_requests_on_item_code"
    t.index ["quote_id"], name: "index_requests_on_quote_id"
  end

  create_table "stocks", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.float "remaining_quantity"
    t.string "reference"
    t.string "unit"
    t.integer "supplier_id"
    t.text "description"
    t.text "remarks"
    t.datetime "date_acquired"
    t.datetime "date_used_up"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float "initial_quantity"
  end

  create_table "supplier_orders", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "offer_id"
    t.string "reference"
    t.datetime "estimated_manufactured_at"
    t.datetime "estimated_delivered_at"
    t.datetime "delivered_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "actual_specs"
    t.index ["offer_id"], name: "index_supplier_orders_on_offer_id"
    t.index ["reference"], name: "index_supplier_orders_on_reference"
  end

  create_table "supplier_purchases", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "order_id"
    t.string "reference"
    t.string "recipient"
    t.string "string"
    t.string "address"
    t.text "delivery"
    t.text "price_basis"
    t.text "remarks"
    t.text "terms"
    t.text "warranty"
    t.datetime "ordered_at"
    t.string "signatory"
    t.string "signatory_position"
    t.boolean "hide_client_in_print"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["order_id"], name: "index_supplier_purchases_on_order_id"
    t.index ["reference"], name: "index_supplier_purchases_on_reference"
  end

  create_table "suppliers", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "emails"
    t.string "contact_numbers"
    t.text "address"
  end

  create_table "users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "read_only"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["read_only"], name: "index_users_on_read_only"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vendor_item_fields", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "vendor_item_id"
    t.string "value"
    t.integer "product_field_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["product_field_id"], name: "index_vendor_item_fields_on_product_field_id"
    t.index ["vendor_item_id"], name: "index_vendor_item_fields_on_vendor_item_id"
  end

  create_table "vendor_items", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "code"
    t.integer "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["product_id"], name: "index_vendor_items_on_product_id"
  end

end
