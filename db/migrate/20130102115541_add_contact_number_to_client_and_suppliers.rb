class AddContactNumberToClientAndSuppliers < ActiveRecord::Migration
  def change
    add_column :suppliers, :emails, :string
    add_column :suppliers, :contact_numbers, :string
    add_column :clients, :emails, :string
    add_column :clients, :contact_numbers, :string
  end
end
