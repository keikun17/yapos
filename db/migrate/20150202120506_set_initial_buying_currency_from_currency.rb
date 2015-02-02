class SetInitialBuyingCurrencyFromCurrency < ActiveRecord::Migration

  def self.up
    Offer.connection.execute("update offers set buying_currency=currency")
  end

  def self.down
  end

end
