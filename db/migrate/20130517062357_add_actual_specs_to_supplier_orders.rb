class AddActualSpecsToSupplierOrders < ActiveRecord::Migration
  def change
    add_column :supplier_orders, :actual_specs, :text
  end
end
