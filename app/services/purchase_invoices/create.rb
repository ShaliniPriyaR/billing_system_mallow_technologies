module PurchaseInvoices
  class Create
    Result = Struct.new(:success?, :invoice, :error)

    def self.call(params)
      new(params).call
    end

    def initialize(params)
      @params = params.deep_dup
    end

    def call
      ActiveRecord::Base.transaction do
        email, invoice_params, items = serialize_params

        customer = Customer.find_or_create_by!(email: email)

        @purchase_invoice = PurchaseInvoice.new(invoice_params.merge(customer: customer))
        @purchase_invoice.save!

        create_items!(items)
        update_received_denominations!(@purchase_invoice.paid_amount)
        update_change_denominations!(@purchase_invoice.balance_amount)

        Result.new(true, @purchase_invoice, nil)
      end
    rescue => e
      Result.new(false, nil, e.message)
    end

    private

    def serialize_params
      items = @params[:items]
      raise "At least one product must be selected" if items.blank?

      paid_amount = @params[:paid_amount].to_d

      subtotal, tax, total = calculate_amounts(items)
      rounded_total = total.floor

      raise "Customer paid less than total amount" if paid_amount < total

      invoice_params = {
        paid_amount: paid_amount,
        subtotal_amount: subtotal,
        tax_amount: tax,
        total_amount: total,
        balance_amount: (paid_amount - rounded_total).floor
      }

      [@params[:email], invoice_params, items]
    end

    def calculate_amounts(items)
      subtotal = BigDecimal("0")
      tax_total = BigDecimal("0")

      items.each do |item|
        product = Product.find(item[:id])
        quantity = item[:quantity].to_i

        line_amount = product.unit_price.to_d * quantity
        line_tax = (line_amount * product.tax_percentage.to_d) / 100

        subtotal += line_amount
        tax_total += line_tax
      end

      [subtotal, tax_total, subtotal + tax_total]
    end

    def create_items!(items)
      items.each do |item|
        product = Product.lock.find(item[:id])
        quantity = item[:quantity].to_i

        raise "Insufficient stock for #{product.name}" if product.stock_available < quantity

        product.update!(stock_available: product.stock_available - quantity)

        @purchase_invoice.invoice_items.create!(
          product: product,
          quantity: quantity,
          unit_price: product.unit_price,
          tax_percentage: product.tax_percentage
        )
      end
    end

    def update_received_denominations!(amount)
      remaining = amount.to_i

      Denomination.lock.order(value: :desc).each do |denom|
        break if remaining.zero?

        count = remaining / denom.value
        next if count.zero?

        denom.update!(available_count: denom.available_count + count)
        remaining -= denom.value * count
      end

      raise "Invalid paid amount" unless remaining.zero?
    end

    def update_change_denominations!(amount)
      remaining = amount.to_i
      change_map = {}

      Denomination.lock.order(value: :desc).each do |denom|
        break if remaining.zero?

        count = [remaining / denom.value, denom.available_count].min
        next if count.zero?

        change_map[denom.value] = count
        denom.update!(available_count: denom.available_count - count)
        remaining -= denom.value * count
      end

      raise "Change cannot be given with available denominations" unless remaining.zero?

      @purchase_invoice.update!(change_denominations: change_map)
    end
  end
end
