class AddQuoteRemarks < ActiveRecord::Migration
  def change
    add_column :quotes, :remarks, :text
  end
end
