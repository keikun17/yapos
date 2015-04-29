class Product < ActiveRecord::Base
  attr_accessible :name, :product_fields_attributes
  has_many :product_fields
  has_many :vendor_items

  accepts_nested_attributes_for :product_fields, allow_destroy: true, :reject_if => lambda { |r| r[:name].blank? &&
                           r[:unit].blank? &&
                           r[:field_type].blank?  }

  default_scope { order(name: :asc) }

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
