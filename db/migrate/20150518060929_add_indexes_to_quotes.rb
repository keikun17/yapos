class AddIndexesToQuotes < ActiveRecord::Migration
  def change
    add_index :quotes, :quote_reference
    add_index :quotes, :client_id
    add_index :requests, :quote_id
  end
end
