class SplitStockQuantityColumns < ActiveRecord::Migration
  def change
    rename_column :stocks, :quantity, :remaining_quantity
    add_column :stocks, :initial_quantity, :float
  end
end
