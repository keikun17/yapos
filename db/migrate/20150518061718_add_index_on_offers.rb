class AddIndexOnOffers < ActiveRecord::Migration
  def change
    add_index :offers, :supplier_id
    add_index :offers, :request_id
  end
end
