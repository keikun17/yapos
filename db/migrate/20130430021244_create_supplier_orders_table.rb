class CreateSupplierOrdersTable < ActiveRecord::Migration
  def change
    create_table :supplier_orders do |t|
      t.references :offer
      t.string :reference

      t.datetime :ordered_at
      t.datetime :estimated_manufactured_at
      t.datetime :manufactured_at
      t.datetime :estimated_delivered_at
      t.datetime :delivered_at

      t.timestamps
    end
  end
end
