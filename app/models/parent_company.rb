class ParentCompany < ActiveRecord::Base
  attr_accessible :name

  has_many :clients
  has_many :quotes, through: :client
  has_many :orders, through: :client

  default_scope -> { order('name asc') }
end

# == Schema Information
#
# Table name: parent_companies
#
#  id   :integer          not null, primary key
#  name :string(255)
#
