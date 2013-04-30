class AddQtyUnitToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :quantity, :float
    add_column :requests, :unit, :string
  end
end
