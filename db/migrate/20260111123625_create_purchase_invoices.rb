class CreatePurchaseInvoices < ActiveRecord::Migration[8.1]
  def change
    create_table :purchase_invoices do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :invoice_number
      t.decimal :subtotal_amount
      t.decimal :total_amount
      t.decimal :paid_amount
      t.decimal :balance_amount
      t.jsonb :change_denominations

      t.timestamps
    end
  end
end
