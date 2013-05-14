class Client < ActiveRecord::Base
  attr_accessible :name, :emails, :contact_numbers, :address

  has_many :quotes

  default_scope -> { order('name asc') }
end

# == Schema Information
#
# Table name: clients
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  emails          :string(255)
#  contact_numbers :string(255)
#  address         :text
#

