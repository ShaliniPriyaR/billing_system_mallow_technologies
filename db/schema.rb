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

ActiveRecord::Schema[8.1].define(version: 2026_01_11_123639) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pgcrypto"

  create_table "customers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.datetime "updated_at", null: false
  end

  create_table "denominations", force: :cascade do |t|
    t.integer "available_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "value"
  end

  create_table "invoice_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "product_id", null: false
    t.bigint "purchase_invoice_id", null: false
    t.integer "quantity"
    t.decimal "tax_percentage"
    t.decimal "unit_price"
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_invoice_items_on_product_id"
    t.index ["purchase_invoice_id"], name: "index_invoice_items_on_purchase_invoice_id"
  end

  create_table "products", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.string "product_code"
    t.integer "stock_available"
    t.decimal "tax_percentage"
    t.decimal "unit_price"
    t.datetime "updated_at", null: false
  end

  create_table "purchase_invoices", force: :cascade do |t|
    t.decimal "balance_amount"
    t.jsonb "change_denominations"
    t.datetime "created_at", null: false
    t.bigint "customer_id", null: false
    t.string "invoice_number"
    t.decimal "paid_amount"
    t.decimal "subtotal_amount"
    t.decimal "total_amount"
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_purchase_invoices_on_customer_id"
  end

  add_foreign_key "invoice_items", "products"
  add_foreign_key "invoice_items", "purchase_invoices"
  add_foreign_key "purchase_invoices", "customers"
end
