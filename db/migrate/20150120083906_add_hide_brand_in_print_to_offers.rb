class AddHideBrandInPrintToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :hide_supplier_in_print, :boolean
  end
end
