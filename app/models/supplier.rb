class Supplier < ActiveRecord::Base
  attr_accessible :name, :emails, :contact_numbers, :address

  has_many :quotes, through: :offers, uniq: true
  has_many :offers
  has_many :supplier_orders, through: :offers

  default_scope order('name asc')

end

# == Schema Information
#
# Table name: suppliers
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  emails          :string(255)
#  contact_numbers :string(255)
#  address         :text
#

