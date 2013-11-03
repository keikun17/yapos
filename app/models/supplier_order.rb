class SupplierOrder < ActiveRecord::Base
  attr_accessible :reference,
    :offer_id,
    :ordered_at, #FIXME : remove this and delegate to supplier_purchase
    :estimated_manufactured_at,
    :estimated_delivered_at,
    :delivered_at,
    :actual_specs

  belongs_to :supplier_purchase,
    foreign_key: :reference,
    primary_key: :reference

  belongs_to :offer

  delegate :request, to: :offer, allow_nil: true


  def delivered?
    !self.delivered_at.blank?
  end

  delegate :supplier_name, to: :offer, allow_nil: true, prefix: false
  delegate :supplier_address, to: :offer, allow_nil: true, prefix: false
  delegate :total_buying_price, to: :offer, allow_nil: true, prefix: true
  delegate :price_vat_status, to: :offer, allow_nil: true, prefix: true
  delegate :price_basis, to: :offer, allow_nil: true, prefix: true

  delegate :ordered_at, to: :supplier_purchase, allow_nil: true, prefix: false
  delegate :ordered_at, to: :supplier_purchase, allow_nil: true, prefix: true

  validate :offer_id, presence: true

  def ordered_from_supplier?
    !self.reference.blank? && !ordered_at.blank?
  end
end

# == Schema Information
#
# Table name: supplier_orders
#
#  id                        :integer          not null, primary key
#  offer_id                  :integer
#  reference                 :string(255)
#  estimated_manufactured_at :datetime
#  manufactured_at           :datetime
#  estimated_delivered_at    :datetime
#  delivered_at              :datetime
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  actual_specs              :text
#

