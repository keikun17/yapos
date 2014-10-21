class VendorItemSerializer < ActiveModel::Serializer
  attributes :id, :code
  has_one :product
end
