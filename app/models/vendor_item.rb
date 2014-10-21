class VendorItem < ActiveRecord::Base
  belongs_to :product
  attr_accessible :code, :product_id
end
