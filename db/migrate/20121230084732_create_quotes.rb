class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.datetime :quote_date
      t.string :quote_reference
      t.string :requester
      t.float :quantity
      t.text :description
      t.string :status

      t.timestamps
    end
  end
end
