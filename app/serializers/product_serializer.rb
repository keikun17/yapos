class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name
end

# == Schema Information
#
# Table name: products
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#
