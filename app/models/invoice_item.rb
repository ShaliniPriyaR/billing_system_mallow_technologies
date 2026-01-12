class InvoiceItem < ApplicationRecord
  belongs_to :purchase_invoice
  belongs_to :product

  validates :quantity, presence: true, numericality: { greater_than: 0 }
end
