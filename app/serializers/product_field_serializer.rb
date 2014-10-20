class ProductFieldSerializer < ActiveModel::Serializer
  attributes :id, :name, :unit, :field_type
  has_one :product
end
