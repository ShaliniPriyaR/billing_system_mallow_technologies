class PurchaseInvoice < ApplicationRecord
  belongs_to :customer
  validates :invoice_number, presence: true, uniqueness: true
  validates :paid_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }

  has_many :invoice_items, dependent: :destroy

  before_validation :generate_invoice_number, on: :create

  def generate_invoice_number
      return if invoice_number.present?

      self.invoice_number = "INV-#{Time.current.strftime('%Y%m%d%H%M%S%L')}"
  end
end
