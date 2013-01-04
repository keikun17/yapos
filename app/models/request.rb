class Request < ActiveRecord::Base
  attr_accessible :requested_specifications, :supplier_id, :quoted_specifications,
    :remarks

  belongs_to :supplier

  delegate :name, :to => :supplier, :prefix =>true, :allow_nil => true
end
