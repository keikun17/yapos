class Offer < ActiveRecord::Base
  attr_accessible :request,
    :specs,
    :price,
    :currency,
    :currency_conversion

  belongs_to :request
  belongs_to :supplier

  delegate :name, :to => :supplier
end
