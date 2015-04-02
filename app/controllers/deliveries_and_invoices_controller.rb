class DeliveriesAndInvoicesController < ApplicationController
  def index
    # @offers = Arel::Table.new(:offers)
    # @offers.where(
    #   @offers[:delivery_receipt_reference].not_eq('').and(@offers[:delivery_receipt_reference].not_eq(nil))
    # ).or(@offers[:sales_invoice_reference].not_eq('')).and(@offers[:sales_invoice_reference].not_eq(nil))

    @offers = Offer.purchased
    @offers = @offers.where("offers.delivery_receipt_reference <> '' or offers.sales_invoice_reference <> ''")
    @offers = @offers.includes([:order, :quote])
    @offers = @offers.page(params[:page]).per_page(50)
    # @offers.where{
    #   ((delivery_receipt_reference.not_eq nil) & (delivery_receipt_reference.not_eq '')) | ((sales_invoice_reference.not_eq nil) & (sales_invoice_reference.not_eq ''))
    # }.page(params[:page]).per_page(50)
  end
end
