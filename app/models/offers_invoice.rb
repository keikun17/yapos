class OffersInvoice < ActiveRecord::Base
  belongs_to :offer
  belongs_to :invoice

  validates_uniqueness_of :offer_id, scope: :invoice_id
end
