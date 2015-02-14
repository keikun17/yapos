class AddServiceFieldToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :service, :boolean
    add_index :requests, :service
  end
end
