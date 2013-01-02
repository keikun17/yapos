class Client < ActiveRecord::Base
  attr_accessible :name, :emails, :contact_numbers

  has_many :quotes
end
