class InvoiceMailer < ApplicationMailer
    default from: "billing_system_mallow_technologies@dummy.com"

    def send_email(purchase_invoice)
        @invoice = purchase_invoice
        email = @invoice.customer.email
        return if email.blank?

        mail(
        to: email,
        subject: "Invoice #{@invoice.invoice_number}"
        )
    end
end
