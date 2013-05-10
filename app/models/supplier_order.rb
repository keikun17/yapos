class SupplierOrder < ActiveRecord::Base
  attr_accessible :reference, :offer_id, :ordered_at,
    :estimated_manufactured_at, :manufactured_at,
    :estimated_delivered_at, :delivered_at, :ordered_at

  belongs_to :supplier_purchase,
    foreign_key: :reference,
    primary_key: :reference
  belongs_to :offer

  def delivered?
    !self.delivered_at.blank?
  end

  delegate :supplier_name, to: :offer, allow_nil: true, prefix: false

  def ordered_from_supplier?
    !self.reference.blank? && !self.ordered_at.blank?
  end
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
#  recipient                 :string(255)
#  address                   :string(255)
#  delivery                  :text
#  price_basis               :text
#  remarks                   :text
#  terms                     :text
#  warranty                  :text
#

