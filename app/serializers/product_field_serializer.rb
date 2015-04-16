class ProductFieldSerializer < ActiveModel::Serializer
  attributes :id, :name, :unit, :field_type
  has_one :product
end

# == Schema Information
#
# Table name: product_fields
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  unit       :string(255)
#  product_id :integer
#  field_type :string(255)
#  created_at :datetime
#  updated_at :datetime
#
