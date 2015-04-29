class Payment < ActiveRecord::Base
  validates :reference, presence: true, uniqueness: true
  has_and_belongs_to_many :invoices, join_table: :payments_invoices
  has_many :orders, through: :invoices
end
