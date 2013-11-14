class CreateTableStock < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.float :quantity
      t.string :reference
      t.string :unit
      t.references :supplier
      t.text :description
      t.text :remarks
      t.datetime :date_acquired
      t.datetime :date_used_up
      t.timestamps
    end
  end
end
