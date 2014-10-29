class PriceMovementController < ApplicationController

  def index
    @offer_with_item_codes = Offer.where.not(vendor_item_code: nil).by_quote_date.decorate
  end

  def show
    @offers = Offer.where(vendor_item_code: params[:item_code]).by_quote_date.decorate
  end

  def uncategorized
    @offers = Offer.where(vendor_item_code: nil).by_quote_date.decorate
  end

end
