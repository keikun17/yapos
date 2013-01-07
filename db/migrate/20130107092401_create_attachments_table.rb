class CreateAttachmentsTable < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.references :attachable, :polymorphic => true
      t.string :document
      t.timestamps
    end
  end
end
