class AddSupplierAndOrderReferencesToQuotes < ActiveRecord::Migration
  def change
    change_table :quotes do |t|
      t.references :supplier
      t.references :order
    end
  end
end
