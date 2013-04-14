class RenameSpecsColumn < ActiveRecord::Migration
  def change
    rename_column :requests, :requested_specifications, :specs
  end
end
