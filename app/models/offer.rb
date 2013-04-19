class Offer < ActiveRecord::Base
  attr_accessible :request,
    :supplier_id, 
    :specs,
    :buying_price,
    :selling_price,
    :currency,
    :currency_conversion,
    :order_reference

  belongs_to :request
  belongs_to :supplier
  belongs_to :order,
    :primary_key => 'reference', 
    :foreign_key => 'order_reference'

  has_one :quote, :through => :request

  scope :purchased, where("order_reference <> '' ")


  delegate :name, to: :supplier, prefix: true, allow_nil: true

  delegate :quote_reference, 
    to: :quote,
    prefix: false,
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
#  po_date             :datetime
#

