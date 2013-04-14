class Supplier < ActiveRecord::Base
  attr_accessible :name, :emails, :contact_numbers, :address

  has_many :quotes
  has_many :offers

  default_scope order('name asc')
end
