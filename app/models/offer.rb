class Offer < ActiveRecord::Base

  attr_accessible :request,
    :supplier_id,
    :specs,
    :buying_price,
    :selling_price,
    :currency,
    :currency_conversion,
    :price_vat_status,
    :order_reference,
    :remarks,
    :terms,
    :delivery,
    :warranty,
    :supplier_order_attributes,
    :total_buying_price,
    :total_selling_price

  belongs_to :request
  belongs_to :supplier
  belongs_to :order,
    :primary_key => 'reference',
    :foreign_key => 'order_reference'

  has_one :quote, :through => :request
  has_one :supplier_order
  has_one :client, :through => :quote

  accepts_nested_attributes_for :supplier_order

  scope :purchased, where("order_reference <> '' ")

  delegate :name, to: :supplier, prefix: true, allow_nil: true
  delegate :quantity, to: :request, prefix: true, allow_nil: true
  delegate :unit, to: :request, prefix: true, allow_nil: true

  delegate :reference,
    to: :quote,
    prefix: true,
    allow_nil: true

  delegate :reference,
    to: :supplier_order,
    prefix: true,
    allow_nil: true

  delegate :ordered_at,
    to: :supplier_order,
    prefix: true,
    allow_nil: true

  delegate :estimated_manufactured_at,
    to: :supplier_order,
    prefix: true,
    allow_nil: true

  delegate :manufactured_at,
    to: :supplier_order,
    prefix: true,
    allow_nil: true

  delegate :estimated_delivered_at,
    to: :supplier_order,
    prefix: true,
    allow_nil: true

  delegate :delivered_at,
    to: :supplier_order,
    prefix: true,
    allow_nil: true

  def update_total_prices
    quantity = self.request_quantity.blank? ? 1 : self.request_quantity
    if self.currency == Currency::LOCAL_CURRENCY
      self.total_buying_price = self.buying_price * quantity
      self.total_selling_price = self.selling_price * quantity
    elsif !self.currency.blank?
      conversion_rate = if conversion_rate.blank?
        Currency::CURRENCY_MAPPING[self.currency] 
      else
        self.conversion_rate
      end
      self.total_buying_price = self.buying_price * quantity * conversion_rate
      self.total_selling_price = self.selling_price * quantity * conversion_rate
    else
      0
    end

    save
  end
end

# == Schema Information
#
# Table name: offers
#
#  id                  :integer          not null, primary key
#  request_id          :integer
#  supplier_id         :integer
#  specs               :text
#  buying_price        :float
#  selling_price       :float
#  currency            :string(255)
#  currency_conversion :float
#  order_reference     :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  remarks             :text
#  terms               :string(255)
#  delivery            :string(255)
#  warranty            :string(255)
#  price_vat_status    :string(255)
#  total_buying_price  :float
#  total_selling_price :float
#

