class ProductField < ActiveRecord::Base
  belongs_to :product
  attr_accessible :name, :unit, :product_id, :field_type
end
