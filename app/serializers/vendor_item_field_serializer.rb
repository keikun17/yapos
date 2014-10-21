class VendorItemFieldSerializer < ActiveModel::Serializer
  attributes :id, :value
  has_one :vendor_item
  has_one :product_field
end
