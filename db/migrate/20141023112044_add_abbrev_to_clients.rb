class AddAbbrevToClients < ActiveRecord::Migration
  def change
    add_column :clients, :abbrev, :string
  end
end
