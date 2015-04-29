class CreateInitialInvoicesFromExistingRecords < ActiveRecord::Migration
  def up
    Offer.where.not(sales_invoice_reference: nil).each do |offer|
      if !offer.sales_invoice_reference.blank?
        puts "Offer # #{offer.id} has SI# #{offer.sales_invoice_reference}"
        invoice = Invoice.find_or_create_by(reference: offer.sales_invoice_reference)

        if invoice.persisted?
          offer.invoices << invoice
          puts "Created invoice with id #{invoice.id}"
        else
          puts "Error trying to create invoice #{invoice.errors.full_messages}"
        end

      end
    end
  end
end
