class AddSalesInvoiceAndDeliveryReceiptToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :delivery_receipt_reference, :string
    add_column :offers, :sales_invoice_reference, :string
    add_index :offers, :delivery_receipt_reference
    add_index :offers, :sales_invoice_reference
  end
end
