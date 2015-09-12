class PaymentsInvoice < ActiveRecord::Base
  belongs_to :payment
  belongs_to :invoice

  validates_uniqueness_of :payment_id, scope: :invoice_id
  validates_uniqueness_of :invoice_id, scope: :payment_id
end

# == Schema Information
#
# Table name: payments_invoices
#
#  id         :integer          not null, primary key
#  invoice_id :integer
#  payment_id :integer
#
