class SupplierOrder < ActiveRecord::Base
  attr_accessible :reference, :offer_id, :ordered_at, 
    :estimated_manufactured_at, :manufactured_at,
    :estimated_delivered_at, :delivered_at

  belongs_to :offer
end

# == Schema Information
#
# Table name: supplier_orders
#
#  id                        :integer          not null, primary key
#  offer_id                  :integer
#  reference                 :string(255)
#  ordered_at                :datetime
#  estimated_manufactured_at :datetime
#  manufactured_at           :datetime
#  estimated_delivered_at    :datetime
#  delivered_at              :datetime
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#

