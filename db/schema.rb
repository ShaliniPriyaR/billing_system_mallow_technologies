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

ActiveRecord::Schema[8.1].define(version: 2026_01_11_145853) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pgcrypto"

  create_table "customers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_customers_on_email", unique: true
  end

  create_table "denominations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "available_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "value"
    t.index ["value"], name: "index_denominations_on_value", unique: true
  end

  create_table "invoice_items", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.uuid "product_id", null: false
    t.uuid "purchase_invoice_id", null: false
    t.integer "quantity"
    t.decimal "tax_percentage"
    t.decimal "unit_price"
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_invoice_items_on_product_id"
    t.index ["purchase_invoice_id"], name: "index_invoice_items_on_purchase_invoice_id"
  end

  create_table "products", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.string "product_code"
    t.integer "stock_available"
    t.decimal "tax_percentage"
    t.decimal "unit_price"
    t.datetime "updated_at", null: false
    t.index ["product_code"], name: "index_products_on_product_code", unique: true
  end

  create_table "purchase_invoices", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "balance_amount"
    t.jsonb "change_denominations"
    t.datetime "created_at", null: false
    t.uuid "customer_id", null: false
    t.string "invoice_number"
    t.decimal "paid_amount"
    t.decimal "subtotal_amount"
    t.decimal "tax_amount"
    t.decimal "total_amount"
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_purchase_invoices_on_created_at"
    t.index ["customer_id"], name: "index_purchase_invoices_on_customer_id"
    t.index ["invoice_number"], name: "index_purchase_invoices_on_invoice_number", unique: true
  end

  add_foreign_key "invoice_items", "products"
  add_foreign_key "invoice_items", "purchase_invoices"
  add_foreign_key "purchase_invoices", "customers"
end
