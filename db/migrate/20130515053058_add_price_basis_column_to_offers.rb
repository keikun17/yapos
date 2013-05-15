class AddPriceBasisColumnToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :price_basis, :string
  end
end
