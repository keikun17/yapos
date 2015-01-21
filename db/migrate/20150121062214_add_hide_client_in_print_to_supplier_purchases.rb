class AddHideClientInPrintToSupplierPurchases < ActiveRecord::Migration
  def change
    add_column :supplier_purchases, :hide_client_in_print, :boolean
  end
end
