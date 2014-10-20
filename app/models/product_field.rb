class ProductField < ActiveRecord::Base
  belongs_to :product
  attr_accessible :name, :unit, :product_id, :field_type
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
