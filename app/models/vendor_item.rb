class VendorItem < ActiveRecord::Base
  belongs_to :product
  attr_accessible :code, :product_id, :product, :vendor_item_fields_attributes

  has_many :product_fields, through: :product
  has_many :vendor_item_fields

  accepts_nested_attributes_for :vendor_item_fields, allow_destroy: true, :reject_if => lambda { |r| r[:value].blank? }

  def self.initialize_fields(product)
    vendor_item = new(product: product)
    product.product_fields.each do |product_field|
      vendor_item.vendor_item_fields.build(product_field: product_field)
    end

    vendor_item
  end
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
