class AddRemarksToOffer < ActiveRecord::Migration
  def change
    add_column :offers, :remarks, :text
  end
end
