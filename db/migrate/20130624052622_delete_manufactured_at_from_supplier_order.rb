class DeleteManufacturedAtFromSupplierOrder < ActiveRecord::Migration
  def up
    remove_column :supplier_orders, :manufactured_at
  end

  def up
    remove_column :supplier_orders, :manufactured_at, :datetime
  end
end
