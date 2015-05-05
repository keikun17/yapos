class Invoice < ActiveRecord::Base
  attr_accessible :reference, :invoice_date, :amount, :payments_attributes

  validates :reference, presence: true, uniqueness: true

  has_many :offers_invoices, dependent: :destroy
  has_many :offers, through: :offers_invoices
  has_many :orders, through: :offers
  has_many :quotes, through: :offers

  has_many :payments_invoices, dependent: :destroy
  has_many :payments, through: :payments_invoices

  accepts_nested_attributes_for :payments,
    :allow_destroy => true,
    :reject_if => lambda { |p| p[:reference].blank? }

end

# == Schema Information
#
# Table name: invoices
#
#  id           :integer          not null, primary key
#  reference    :string(255)
#  invoice_date :datetime
#  amount       :decimal(15, 2)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
