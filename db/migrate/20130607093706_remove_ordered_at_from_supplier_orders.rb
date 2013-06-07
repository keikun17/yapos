class RemoveOrderedAtFromSupplierOrders < ActiveRecord::Migration
  def up
    remove_column :supplier_orders, :ordered_at
  end

  def down
    add_column :supplier_orders, :ordered_at, :datetime
  end
end
