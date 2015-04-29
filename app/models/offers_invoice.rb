class OffersInvoice < ActiveRecord::Base
  belongs_to :offer
  belongs_to :invoice
end
