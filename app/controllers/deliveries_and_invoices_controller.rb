class DeliveriesAndInvoicesController < ApplicationController
  def index
    @offers = Offer.purchased
      .delivered
      .includes([ :quote, :supplier_order, :invoices, :client, :supplier ])

    filter_offers_by_client_an_supplier

    if params[:sort].present?
      @offers = sort(@offers, params[:sort], params[:direction])
    end

    @offers = @offers.page(params[:page]).per_page(50).decorate
  end

  def client_ordered_20_days_ago
    @offers = Offer.purchased
      .undelivered
      .includes([:order, :quote, :supplier_order, :invoices, :client, :supplier])
      .where("orders.purchase_date < ?", 20.days.ago)

    filter_offers_by_client_an_supplier

    @offers = @offers.order("orders.purchase_date desc")
    @offers = @offers.page(params[:page]).per_page(50).decorate
  end

  private

  def filter_offers_by_client_an_supplier
    if !params[:client_id].blank?
      @offers = @offers.where(quotes: {client_id: params[:client_id]})
      @client = Client.find(params[:client_id])
    end

    if !params[:supplier_id].blank?
      @offers = @offers.includes(:supplier).where(suppliers: {id: params[:supplier_id]})
    end
  end

  def sort(offers, by, direction)

    direction = case direction
                when 'desc'
                  :desc
                when 'asc'
                  :asc
                end

    case by
    when "dr"
      offers = offers.order(delivery_receipt_reference: direction)
    when 'delivery-date'
      offers = offers.order("supplier_orders.delivered_at IS NOT NULL, supplier_orders.delivered_at #{direction.to_s}")
    end

    offers
  end

end
