class Client < ActiveRecord::Base
  attr_accessible :name, :emails, :contact_numbers, :address, :abbrev, :parent_company_id

  has_many :quotes
  has_many :orders, through: :quotes
  has_many :requests, through: :quotes
  has_many :offers, through: :quotes
  belongs_to :parent_company

  default_scope -> { order('name asc') }
end

# == Schema Information
#
# Table name: clients
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  emails            :string(255)
#  contact_numbers   :string(255)
#  address           :text(65535)
#  abbrev            :string(255)
#  parent_company_id :integer
#
