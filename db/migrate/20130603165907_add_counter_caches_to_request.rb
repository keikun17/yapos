class AddCounterCachesToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :client_purchased_count, :integer, default: 0
    add_column :requests, :non_client_purchased_count, :integer, default: 0
  end
end
