class Attachment < ActiveRecord::Base
  attr_accessible :document

  belongs_to :attachable, :polymorphic => true

  mount_uploader :document, DocumentUploader
end

# == Schema Information
#
# Table name: attachments
#
#  id              :integer          not null, primary key
#  attachable_id   :integer
#  attachable_type :string(255)
#  document        :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

