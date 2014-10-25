class PriceMovementController < ApplicationController

  def index
    @offer_with_item_codes = Offer.where.not(vendor_item_code: nil).decorate
  end

  def show
    @offers = Offer.where(vendor_item_code: params[:item_code]).decorate
  end

end
