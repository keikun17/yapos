class AddVendorItemIdToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :vendor_item_id, :string
    add_index :offers, :vendor_item_id
  end
end
