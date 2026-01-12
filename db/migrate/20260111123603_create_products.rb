class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products, id: :uuid do |t|
      t.string :name
      t.string :product_code
      t.integer :stock_available
      t.decimal :unit_price
      t.decimal :tax_percentage

      t.timestamps
    end
  end
end
