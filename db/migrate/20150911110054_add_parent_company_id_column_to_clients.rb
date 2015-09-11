class AddParentCompanyIdColumnToClients < ActiveRecord::Migration
  def change
    change_table :clients do |t|
      t.references :parent_company
    end

    add_index :clients, :parent_company_id
  end
end
