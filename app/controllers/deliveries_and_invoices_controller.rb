class DeliveriesAndInvoicesController < ApplicationController
  def index
    @offers = Offer.purchased
      .where("offers.delivery_receipt_reference <> '' or offers.sales_invoice_reference <> ''")
      .includes([:order, :quote])
      .page(params[:page]).per_page(50)
  end
end
