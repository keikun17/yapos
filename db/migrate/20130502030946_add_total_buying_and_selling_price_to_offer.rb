class AddTotalBuyingAndSellingPriceToOffer < ActiveRecord::Migration
  def change
    add_column :offers, :total_buying_price, :float
    add_column :offers, :total_selling_price, :float

    offers = Offer.all
    offers.each do |offer|
      offer.update_attribute(:total_buying_price, offer.buying_price)
      offer.update_attribute(:total_selling_price, offer.selling_price)
    end

  end
end
