class AddTitleToQuote < ActiveRecord::Migration
  def change
    add_column :quotes, :title, :text
    add_column :quotes, :blurb, :text
  end
end
