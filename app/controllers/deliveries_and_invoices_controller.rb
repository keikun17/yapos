class DeliveriesAndInvoicesController < ApplicationController
  def index
    @offers = Offer.purchased
      .where("offers.delivery_receipt_reference <> '' or offers.sales_invoice_reference <> ''")
      .includes([:order, :quote, :supplier_order])
      .order("supplier_orders.delivered_at desc")
      .page(params[:page]).per_page(50)
  end
end
