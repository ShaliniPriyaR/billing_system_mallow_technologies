json.extract! product, :id, :name, :product_code, :stock_available, :unit_price, :tax_percentage, :created_at, :updated_at
json.url product_url(product, format: :json)
