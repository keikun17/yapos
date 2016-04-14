class AddReadOnlyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :read_only, :boolean
    add_index :users, :read_only
  end

end
