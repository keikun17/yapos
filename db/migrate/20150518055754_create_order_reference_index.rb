class CreateOrderReferenceIndex < ActiveRecord::Migration
  def change
    add_index :orders, :reference
  end
end
