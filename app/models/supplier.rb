class Supplier < ActiveRecord::Base
  attr_accessible :name, :emails, :contact_numbers, :address

  has_many :quotes
end
