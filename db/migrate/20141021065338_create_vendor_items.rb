class CreateVendorItems < ActiveRecord::Migration
  def change
    create_table :vendor_items do |t|
      t.string :code
      t.references :product, index: true

      t.timestamps
    end
  end
end
