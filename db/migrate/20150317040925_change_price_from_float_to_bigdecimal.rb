class ChangePriceFromFloatToBigdecimal < ActiveRecord::Migration
  def change
    change_column :offers, :total_buying_price, :decimal, precision: 15, scale: 2
    change_column :offers, :total_selling_price, :decimal, precision: 15, scale: 2
    change_column :offers, :buying_price, :decimal, precision: 15, scale: 2
    change_column :offers, :selling_price, :decimal, precision: 15, scale: 2
  end
end
