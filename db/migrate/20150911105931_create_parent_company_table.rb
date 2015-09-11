class CreateParentCompanyTable < ActiveRecord::Migration
  def change
    create_table :parent_company_tables do |t|
      t.string :name
    end
  end
end
