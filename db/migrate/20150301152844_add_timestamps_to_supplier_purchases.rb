class AddTimestampsToSupplierPurchases < ActiveRecord::Migration
  def change
    add_column :supplier_purchases, :created_at, :datetime
    add_column :supplier_purchases, :updated_at, :datetime
  end
end
