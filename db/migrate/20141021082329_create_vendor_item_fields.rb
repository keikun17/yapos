class CreateVendorItemFields < ActiveRecord::Migration
  def change
    create_table :vendor_item_fields do |t|
      t.references :vendor_item, index: true
      t.string :value
      t.references :product_field, index: true

      t.timestamps
    end
  end
end
