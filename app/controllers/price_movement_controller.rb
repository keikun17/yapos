class PriceMovementController < ApplicationController

  def index
    @offer_with_item_codes = Offer.where("vendor_item_code <> ''").by_quote_date.decorate
  end

  def show
    @vendor_item = VendorItem.find(params[:vendor_item_id])
    @offers = @vendor_item.offers
    @last_sold = @offers.purchased.last.try(:decorate)
    @offers = @offers.by_quote_date.decorate
  end

  def uncategorized
    @offers = Offer.where(vendor_item_code: nil).by_quote_date.paginate(page: params[:page], per_page: 40).decorate
  end

end
