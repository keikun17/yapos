class Request < ActiveRecord::Base
  attr_accessible :specs, 
    :quantity, 
    :unit,
    :remarks,
    :offers_attributes

  belongs_to :quote
  belongs_to :supplier
  has_many :offers, dependent: :destroy

  accepts_nested_attributes_for :offers,
    :allow_destroy => true,
    :reject_if => lambda { |o| o[:specs].blank? &&
                          o[:price].blank? 
  }
  delegate :name, :to => :supplier, :prefix => true, :allow_nil => true

  validates :specs, :presence => true

end

# == Schema Information
#
# Table name: requests
#
#  id                    :integer          not null, primary key
#  specs                 :text
#  quote_id              :integer
#  supplier_id           :integer
#  quoted_specifications :text
#  remarks               :text
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  quantity              :float
#  unit                  :string(255)
#

