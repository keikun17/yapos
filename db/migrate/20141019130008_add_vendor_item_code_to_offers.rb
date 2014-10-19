class AddVendorItemCodeToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :vendor_item_code, :string
    add_index :offers, :vendor_item_code
  end
end
