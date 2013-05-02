class ComputeTotalOfferPrices < ActiveRecord::Migration
  def change
    Offer.all.map(&:update_total_prices)
  end
end
