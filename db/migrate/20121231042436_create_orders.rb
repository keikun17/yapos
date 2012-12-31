class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :reference
      t.datetime :purchase_date

      t.timestamps
    end
  end
end
