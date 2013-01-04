class CreateRequestsTable < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.text :requested_specifications
      t.references :quote
      t.references :supplier
      t.text :quoted_specifications
      t.text :remarks
      t.timestamps
    end
  end
end
