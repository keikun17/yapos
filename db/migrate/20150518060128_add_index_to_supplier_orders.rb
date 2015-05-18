class AddIndexToSupplierOrders < ActiveRecord::Migration
  def change
    add_index :supplier_orders, :offer_id
    add_index :supplier_orders, :reference
  end
end
