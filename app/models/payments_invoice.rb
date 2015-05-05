class PaymentsInvoice < ActiveRecord::Base
  belongs_to :payment
  belongs_to :invoice

  validates_uniqueness_of :payment_id, scope: :invoice_id
  validates_uniqueness_of :invoice_id, scope: :payment_id
end
