class VendorItemSerializer < ActiveModel::Serializer
  attributes :id, :code
  has_one :product
end

# == Schema Information
#
# Table name: vendor_items
#
#  id         :integer          not null, primary key
#  code       :string(255)
#  product_id :integer
#  created_at :datetime
#  updated_at :datetime
#
