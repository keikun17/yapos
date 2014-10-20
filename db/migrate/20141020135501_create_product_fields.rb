class CreateProductFields < ActiveRecord::Migration
  def change
    create_table :product_fields do |t|
      t.string :name
      t.string :unit
      t.references :product, index: true
      t.string :field_type

      t.timestamps
    end
  end
end
