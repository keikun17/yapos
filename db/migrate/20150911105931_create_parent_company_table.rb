class CreateParentCompanyTable < ActiveRecord::Migration
  def change
    create_table :parent_companies do |t|
      t.string :name
    end
  end
end
