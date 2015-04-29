class CreatePayments < ActiveRecord::Migration
  def change

    create_table :invoices do |t|
      t.string :reference
      t.datetime :invoice_date
      t.decimal :amount, precision: 15, scale: 2

      t.timestamps null: false
    end

    create_table :offers_invoices do |t|
      t.belongs_to :offer, index: true
      t.belongs_to :invoice, index: true
    end

    create_table :payments do |t|
      t.string :reference
      t.datetime :date_received
      t.decimal :amount, precision: 15, scale: 2

      t.timestamps null: false
    end

    create_table :payments_invoices do |t|
      t.belongs_to :invoice, index: true
      t.belongs_to :payment, index: true
    end


  end
end
