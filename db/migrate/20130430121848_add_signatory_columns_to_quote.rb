class AddSignatoryColumnsToQuote < ActiveRecord::Migration
  def change
    add_column :quotes, :signatory, :string
    add_column :quotes, :signatory_position, :string
    add_column :quotes, :contact_person, :string
  end
end
