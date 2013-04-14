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
