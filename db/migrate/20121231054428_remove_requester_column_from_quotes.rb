class RemoveRequesterColumnFromQuotes < ActiveRecord::Migration
  def up
    remove_column :quotes, :requester
  end

  def down
    add_column :quotes, :requester, :string
  end
end
