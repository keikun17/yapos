class InsertRemarksAndSignatoryColumnToSupplierPurchases < ActiveRecord::Migration
  def change
    add_column :supplier_purchases, :signatory, :string
    add_column :supplier_purchases, :signatory_position, :string
  end

end
