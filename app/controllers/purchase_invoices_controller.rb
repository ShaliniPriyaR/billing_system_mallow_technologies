class PurchaseInvoicesController < ApplicationController
  before_action :set_purchase_invoice, only: %i[ show ]
  before_action :fetch_denominations_products, only: %i[new create]

  # GET /purchase_invoices or /purchase_invoices.json
  def index
    @search = params[:email]
    @invoices =PurchaseInvoice.includes(:customer).order(created_at: :desc)

    if @search.present?
      @invoices = @invoices.joins(:customer).where("customers.email ILIKE ?", "%#{@search}%")
    end
  end

  # GET /purchase_invoices/1 or /purchase_invoices/1.json
  def show
  end

  # GET /purchase_invoices/new
  def new
    @purchase_invoice = PurchaseInvoice.new
  end

  # GET /purchase_invoices/1/edit
  def edit
  end

  # POST /purchase_invoices or /purchase_invoices.json
  def create
    result = PurchaseInvoices::Create.call(purchase_invoice_params)

    if result.success?
      InvoiceMailer.send_email(result.invoice).deliver_later

      redirect_to purchase_invoice_path(result.invoice)
    else
      flash.now[:alert] = result.error
      render :new, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase_invoice
      @purchase_invoice = PurchaseInvoice.find(params.expect(:id))
    end

    def fetch_denominations_products
      @denominations = Denomination.all
      @products = Product.all
      @product_count = @products.count
    end

    # Only allow a list of trusted parameters through.
    def purchase_invoice_params
      params.require(:purchase_invoice).permit(:email, :paid_amount, items: [:id, :quantity])
    end
end
