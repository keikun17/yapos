class VendorItemField < ActiveRecord::Base
  belongs_to :vendor_item
  belongs_to :product_field
end
