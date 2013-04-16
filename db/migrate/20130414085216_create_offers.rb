class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.references :request
      t.references :supplier
      t.text       :specs
      t.float      :buying_price
      t.float      :selling_price
      t.string     :currency
      t.float      :currency_conversion
      t.string     :order_reference
      t.timestamps
    end
  end
end
