class CreateInvoiceItems < ActiveRecord::Migration[8.1]
  def change
    create_table :invoice_items, id: :uuid do |t|
      t.references :purchase_invoice, type: :uuid, null: false, foreign_key: true
      t.references :product, type: :uuid, null: false, foreign_key: true
      t.integer :quantity
      t.decimal :unit_price
      t.decimal :tax_percentage

      t.timestamps
    end
  end
end
