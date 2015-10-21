class AddFromStockColumnToOffers < ActiveRecord::Migration
  def change22
    add_column :offers, :from_stock, :boolean, default: false
  end

end
