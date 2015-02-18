class DefaultOfferServiceToFalse < ActiveRecord::Migration
  def up
    change_column :offers, :service, :boolean, default: false
    Offer.where(service: nil).update_all(service: false)
  end

  def down
    change_column :offers, :service, :boolean, default: nil
  end
end
