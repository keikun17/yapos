class PriceMovementController < ApplicationController

  def show
    @offer_with_item_codes = Offer.where.not(vendor_item_code: nil)
  end

end
