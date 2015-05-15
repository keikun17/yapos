class DeliveriesAndInvoicesController < ApplicationController
  def index
    @offers = Offer.purchased
      .where("offers.delivery_receipt_reference <> '' or offers.sales_invoice_reference <> ''")
      .includes([:order, :quote, :supplier_order])
      .order("supplier_orders.delivered_at desc")

    if !params[:client_id].blank?
      @offers = @offers.where(quotes: {client_id: params[:client_id]})
    end

    if !params[:supplier_id].blank?
      @offers = @offers.includes(:supplier).where(suppliers: {id: params[:supplier_id]})
    end

    @offers = @offers.page(params[:page]).per_page(50)
  end
end
