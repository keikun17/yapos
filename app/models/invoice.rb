class Invoice < ActiveRecord::Base
  attr_accessible :reference, :invoice_date, :amount

  validates :reference, presence: true, uniqueness: true

  has_many :offers_invoices, dependent: :destroy
  has_many :offers, through: :offers_invoices
  has_many :orders, through: :offers

  has_and_belongs_to_many :payments, join_table: :payments_invoices

end
