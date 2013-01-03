class AddCustomClientAndSupplierToOrder < ActiveRecord::Migration
  def change
    change_table :orders do |t|
      t.references :supplier
      t.references :client
    end
  end
end
