class Product < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    validates :product_code, presence: true, uniqueness: true
    validates :unit_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :stock_available, numericality: { greater_than_or_equal_to: 0 }

    has_many :invoice_items, dependent: :restrict_with_error
end
