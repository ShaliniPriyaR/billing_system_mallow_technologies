# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Product.create!([
  { name: "Ball Pen", product_code: "P001", stock_available: 200, unit_price: 10.00, tax_percentage: 5 },
  { name: "Gel Pen", product_code: "P002", stock_available: 150, unit_price: 15.00, tax_percentage: 5 },
  { name: "Pencil", product_code: "P003", stock_available: 300, unit_price: 5.00 },
  { name: "Notebook A4", product_code: "P004", stock_available: 80, unit_price: 80.00, tax_percentage: 12 },
  { name: "Eraser", product_code: "P005", stock_available: 250, unit_price: 3.00, tax_percentage: 5 },
  { name: "Sharpener", product_code: "P006", stock_available: 180, unit_price: 4.00, tax_percentage: 5 },
  { name: "Marker Pen", product_code: "P007", stock_available: 120, unit_price: 25.00 },
  { name: "Highlighter", product_code: "P008", stock_available: 90, unit_price: 30.00, tax_percentage: 12 },
  { name: "Stapler", product_code: "P009", stock_available: 40, unit_price: 120.00, tax_percentage: 18 }
])

Denomination.create!([
  { value: 500, available_count: 10 },
  { value: 50, available_count: 20 },
  { value: 20, available_count: 30 },
  { value: 10,  available_count: 50 },
  { value: 5,  available_count: 100 },
  { value: 2,  available_count: 100 },
  { value: 1,  available_count: 100 }
])
