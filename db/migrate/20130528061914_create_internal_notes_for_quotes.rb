class CreateInternalNotesForQuotes < ActiveRecord::Migration
  def change
    add_column :quotes, :internal_notes, :text
  end
end
