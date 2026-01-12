class AddIndexes < ActiveRecord::Migration[8.1]
  def change
    # products
    add_index :products, :product_code, unique: true

    # customers
    add_index :customers, :email, unique: true

    # purchase_invoices
    add_index :purchase_invoices, :invoice_number, unique: true
    add_index :purchase_invoices, :created_at

    # denominations
    add_index :denominations, :value, unique: true
  end
end
