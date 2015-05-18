class DeliveriesAndInvoicesController < ApplicationController
  def index
    @offers = Offer.purchased
      .where("offers.delivery_receipt_reference <> ''")
      .includes([:order, :quote, :supplier_order])

    if !params[:client_id].blank?
      @offers = @offers.where(quotes: {client_id: params[:client_id]})
    end

    if !params[:supplier_id].blank?
      @offers = @offers.includes(:supplier).where(suppliers: {id: params[:supplier_id]})
    end

    if params[:sort].present?
      @offers = sort(@offers, params[:sort], params[:direction])
    end

    @offers = @offers.page(params[:page]).per_page(50)
  end


  private

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
    end

    offers
  end

end
