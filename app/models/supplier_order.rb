class SupplierOrder < ActiveRecord::Base
  attr_accessible :reference,
    :offer_id,
    :ordered_at, #FIXME : remove this and delegate to supplier_purchase
    :estimated_manufactured_at,
    :estimated_delivered_at,
    :delivered_at,
    :actual_specs,
    :offer_attributes

  belongs_to :supplier_purchase,
    inverse_of: :supplier_orders,
    primary_key: :reference,
    foreign_key: :reference

  belongs_to :offer, inverse_of: :supplier_order
  has_one :quote, through: :offer
  has_one :order, through: :offer
  has_one :supplier, through: :offer
  has_one :client, through: :offer
  accepts_nested_attributes_for :offer, update_only: true

  delegate :request, to: :offer, allow_nil: true


  def delivered?
    !self.delivered_at.blank?
  end

  delegate :name, to: :supplier, allow_nil: true, prefix: true
  delegate :address, to: :supplier, allow_nil: true, prefix: true

  delegate :total_buying_price, to: :offer, allow_nil: true, prefix: true
  delegate :total_currency_buying_price, to: :offer, allow_nil: true, prefix: true
  delegate :price_vat_status, to: :offer, allow_nil: true, prefix: true
  delegate :price_basis, to: :offer, allow_nil: true, prefix: true

  delegate :ordered_at, to: :supplier_purchase, allow_nil: true, prefix: false
  delegate :ordered_at, to: :supplier_purchase, allow_nil: true, prefix: true

  validates :offer_id, presence: true

  def ordered_from_supplier?
    !self.reference.blank? && !ordered_at.blank?
  end

  def estimated_delivery_date
    self.estimated_delivered_at.to_date.to_s(:long) if self.estimated_delivered_at
  end

  def estimated_manufacture_date
    self.estimated_manufactured_at.to_date.to_s(:long) if self.estimated_manufactured_at
  end

  def delivery_date
    self.delivered_at.to_date.to_s(:long) if self.delivered_at
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
#  estimated_delivered_at    :datetime
#  delivered_at              :datetime
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  actual_specs              :text(65535)
#
