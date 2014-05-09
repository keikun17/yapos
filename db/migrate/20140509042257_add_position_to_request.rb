class AddPositionToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :position, :integer
  end
end
