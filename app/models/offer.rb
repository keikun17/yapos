class Offer < ActiveRecord::Base
  attr_accessible :request,
    :supplier_id, 
    :specs,
    :price,
    :currency,
    :currency_conversion

  belongs_to :request
  belongs_to :supplier

  delegate :name, to: :supplier, prefix: true, allow_nil: true
end

# == Schema Information
#
# Table name: offers
#
#  id                  :integer          not null, primary key
#  request_id          :integer
#  supplier_id         :integer
#  specs               :text
#  price               :float
#  currency            :string(255)
#  currency_conversion :float
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

