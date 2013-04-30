class AddTaxStatusToOffer < ActiveRecord::Migration
  def change
    add_column :offers, :price_vat_status, :string
  end
end
