class Payment < ActiveRecord::Base
  attr_accessible :reference, :date_received, :amount

  validates :reference, presence: true, uniqueness: true
  has_and_belongs_to_many :invoices, join_table: :payments_invoices
  has_many :orders, through: :invoices
  has_many :offers, through: :invoices
  has_many :quotes, through: :invoices

end

# == Schema Information
#
# Table name: payments
#
#  id            :integer          not null, primary key
#  reference     :string(255)
#  date_received :datetime
#  amount        :decimal(15, 2)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
