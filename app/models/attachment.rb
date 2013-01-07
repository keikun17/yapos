class Attachment < ActiveRecord::Base
  attr_accessible :document

  belongs_to :attachable, :polymorphic => true

  mount_uploader :document, DocumentUploader
end
