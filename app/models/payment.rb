class Payment < ActiveRecord::Base
  validates :reference, presence: true, uniqueness: true
  has_and_belongs_to_many :orders, join_table: :orders_payments
end
