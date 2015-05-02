class Invoice < ActiveRecord::Base
  attr_accessible :reference, :invoice_date, :amount

  validates :reference, presence: true, uniqueness: true

  has_many :offers_invoices, dependent: :destroy
  has_many :offers, through: :offers_invoices
  has_many :orders, through: :offers

  has_and_belongs_to_many :payments, join_table: :payments_invoices

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
