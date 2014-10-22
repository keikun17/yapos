class AddItemCodeToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :item_code, :string
    add_index :requests, :item_code
  end
end
