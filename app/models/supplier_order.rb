class SupplierOrder < ActiveRecord::Base
  attr_accessible :reference, :offer_id, :ordered_at, 
    :estimated_manufactured_at, :manufactured_at,
    :estimated_delivered_at, :delivered_at

  belongs_to :offer
end
