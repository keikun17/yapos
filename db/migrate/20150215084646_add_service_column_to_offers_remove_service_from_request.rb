class AddServiceColumnToOffersRemoveServiceFromRequest < ActiveRecord::Migration
  def change
    add_column :offers, :service, :boolean
    add_index :offers, :service

    remove_index :requests, :service
    remove_column :requests, :service
  end
end
