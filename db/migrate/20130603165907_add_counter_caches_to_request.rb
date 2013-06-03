class AddCounterCachesToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :client_purchased_count, :integer
    add_column :requests, :non_client_purchased_count, :integer
  end
end
