class CreateOfferSummaryColumn < ActiveRecord::Migration
  def change
    add_column :offers, :summary, :string
    add_index :offers, :summary
  end
end
