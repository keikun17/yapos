class AddIndexToQuotesQuoteDate < ActiveRecord::Migration
  def change
    add_index :quotes, :quote_date
  end
end
