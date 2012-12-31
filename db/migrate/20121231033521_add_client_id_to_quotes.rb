class AddClientIdToQuotes < ActiveRecord::Migration
  def up
    change_table :quotes do |t|
      t.references :client
    end
  end

  def down
    remove_column :quotes, :client_id
  end
end
