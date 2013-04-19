class AddOrderReferenceIndexToOffer < ActiveRecord::Migration
  def change
    add_index :offers, :order_reference
  end
end
