class PurchaseInvoicesController < ApplicationController
  before_action :set_purchase_invoice, only: %i[ show edit update destroy ]

  # GET /purchase_invoices or /purchase_invoices.json
  def index
    @purchase_invoices = PurchaseInvoice.all
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
    @purchase_invoice = PurchaseInvoice.new(purchase_invoice_params)

    respond_to do |format|
      if @purchase_invoice.save
        format.html { redirect_to @purchase_invoice, notice: "Purchase invoice was successfully created." }
        format.json { render :show, status: :created, location: @purchase_invoice }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @purchase_invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /purchase_invoices/1 or /purchase_invoices/1.json
  def update
    respond_to do |format|
      if @purchase_invoice.update(purchase_invoice_params)
        format.html { redirect_to @purchase_invoice, notice: "Purchase invoice was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @purchase_invoice }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @purchase_invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchase_invoices/1 or /purchase_invoices/1.json
  def destroy
    @purchase_invoice.destroy!

    respond_to do |format|
      format.html { redirect_to purchase_invoices_path, notice: "Purchase invoice was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase_invoice
      @purchase_invoice = PurchaseInvoice.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def purchase_invoice_params
      params.expect(purchase_invoice: [ :customer_id, :invoice_number, :subtotal_amount, :total_amount, :paid_amount, :balance_amount, :change_denominations ])
    end
end
