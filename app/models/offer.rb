class Offer < ActiveRecord::Base
  attr_accessible :request,
    :supplier_id, 
    :specs,
    :buying_price,
    :selling_price,
    :currency,
    :currency_conversion,
    :order_reference, 
    :remarks, 
    :supplier_order_attributes

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
#

