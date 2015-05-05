class OffersInvoice < ActiveRecord::Base
  belongs_to :offer
  belongs_to :invoice

  validates_uniqueness_of :offer_id, scope: :invoice_id
  validates_uniqueness_of :invoice_id, scope: :offer_id
end

# == Schema Information
#
# Table name: offers_invoices
#
#  id         :integer          not null, primary key
#  offer_id   :integer
#  invoice_id :integer
#
