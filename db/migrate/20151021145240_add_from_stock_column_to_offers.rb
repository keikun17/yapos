class AddFromStockColumnToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :from_stock, :boolean, default: false
  end

end
