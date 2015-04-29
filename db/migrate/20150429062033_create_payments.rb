class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :reference
      t.datetime :date_received
      t.decimal :amount, precision: 15, scale: 2

      t.timestamps null: false
    end

    create_table :orders_payments do |t|
      t.belongs_to :orders, index: true
      t.belongs_to :payments, index: true
    end
  end
end
