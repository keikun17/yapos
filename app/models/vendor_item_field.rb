class VendorItemField < ActiveRecord::Base
  belongs_to :vendor_item
  belongs_to :product_field
end

# == Schema Information
#
# Table name: vendor_item_fields
#
#  id               :integer          not null, primary key
#  vendor_item_id   :integer
#  value            :string(255)
#  product_field_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#
