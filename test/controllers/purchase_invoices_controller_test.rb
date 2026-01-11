require "test_helper"

class PurchaseInvoicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @purchase_invoice = purchase_invoices(:one)
  end

  test "should get index" do
    get purchase_invoices_url
    assert_response :success
  end

  test "should get new" do
    get new_purchase_invoice_url
    assert_response :success
  end

  test "should create purchase_invoice" do
    assert_difference("PurchaseInvoice.count") do
      post purchase_invoices_url, params: { purchase_invoice: { balance_amount: @purchase_invoice.balance_amount, change_denominations: @purchase_invoice.change_denominations, customer_id: @purchase_invoice.customer_id, invoice_number: @purchase_invoice.invoice_number, paid_amount: @purchase_invoice.paid_amount, subtotal_amount: @purchase_invoice.subtotal_amount, total_amount: @purchase_invoice.total_amount } }
    end

    assert_redirected_to purchase_invoice_url(PurchaseInvoice.last)
  end

  test "should show purchase_invoice" do
    get purchase_invoice_url(@purchase_invoice)
    assert_response :success
  end

  test "should get edit" do
    get edit_purchase_invoice_url(@purchase_invoice)
    assert_response :success
  end

  test "should update purchase_invoice" do
    patch purchase_invoice_url(@purchase_invoice), params: { purchase_invoice: { balance_amount: @purchase_invoice.balance_amount, change_denominations: @purchase_invoice.change_denominations, customer_id: @purchase_invoice.customer_id, invoice_number: @purchase_invoice.invoice_number, paid_amount: @purchase_invoice.paid_amount, subtotal_amount: @purchase_invoice.subtotal_amount, total_amount: @purchase_invoice.total_amount } }
    assert_redirected_to purchase_invoice_url(@purchase_invoice)
  end

  test "should destroy purchase_invoice" do
    assert_difference("PurchaseInvoice.count", -1) do
      delete purchase_invoice_url(@purchase_invoice)
    end

    assert_redirected_to purchase_invoices_url
  end
end
