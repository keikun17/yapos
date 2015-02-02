class AddBuyingCurrencyToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :buying_currency, :string
  end
end
