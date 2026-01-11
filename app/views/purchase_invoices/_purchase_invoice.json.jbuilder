json.extract! purchase_invoice, :id, :customer_id, :invoice_number, :subtotal_amount, :total_amount, :paid_amount, :balance_amount, :change_denominations, :created_at, :updated_at
json.url purchase_invoice_url(purchase_invoice, format: :json)
