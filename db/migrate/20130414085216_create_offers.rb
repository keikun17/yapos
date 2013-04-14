class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.references :request
      t.references :supplier
      t.text       :specs
      t.float      :price
      t.string     :currency
      t.float      :currency_conversion
      t.timestamps
    end
  end
end
