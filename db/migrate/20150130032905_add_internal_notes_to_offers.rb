class AddInternalNotesToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :internal_notes, :text
  end
end
