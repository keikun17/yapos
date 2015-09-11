class ParentCompany < ActiveRecord::Base
  attr_accessible :name

  has_many :clients
  has_many :quotes, through: :client
  has_many :orders, through: :client

  default_scope -> { order('name asc') }
end
