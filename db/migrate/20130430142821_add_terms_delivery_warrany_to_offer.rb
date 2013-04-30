class AddTermsDeliveryWarranyToOffer < ActiveRecord::Migration
  def change
    add_column :offers, :terms, :string
    add_column :offers, :delivery, :string
    add_column :offers, :warranty, :string
  end
end
