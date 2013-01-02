class AddCustomPrToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :custom_quote_reference, :string
  end
end
