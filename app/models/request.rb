class Request < ActiveRecord::Base
  attr_accessible :specs, 
    :supplier_id, 
    :remarks

  belongs_to :supplier
  has_many :offers

  accepts_nested_attributes_for :offers,
    :allow_destroy => true,
    :reject_if => lambda { |o| a[:specs].blank? &&
                          o[:price].blank? 
  }
  delegate :name, :to => :supplier, :prefix =>true, :allow_nil => true

end
