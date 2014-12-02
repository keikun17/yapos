require 'rails_helper'

RSpec.describe VendorItem, :type => :model do
  include_context "AR Belt Product with 3 Vendor Items"

  describe "#find_with_fields" do
    it "Searching for 'EP100, 5 x 3' returns vendor items with the matching field attributes" do

      method_call  = VendorItem.find_with_fields([
        {vendor_item_fields: {product_field_id: field_ep.id        , value: '100' }},
        {vendor_item_fields: {product_field_id: field_top_cover.id    , value: '5'}},
        {vendor_item_fields: {product_field_id: field_bottom_cover.id , value: '3' }}
      ])

      expect(method_call).to include(ep100x5x3,ep100x1000mmx5x3)
      expect(method_call).not_to include(ep200x6x2, ep100x5x2)
    end
  end

  describe "#find_with_exact_fields" do
    it "Searching for 'EP100, 5 x 3' returns the vendor item with the exact field value (does not include the ones with common specs and more)" do
      method_call  = VendorItem.find_with_exact_fields([
        {vendor_item_fields: {product_field_id: field_ep.id        , value: '100' }},
        {vendor_item_fields: {product_field_id: field_top_cover.id    , value: '5'}},
        {vendor_item_fields: {product_field_id: field_bottom_cover.id , value: '3' }}
      ])

      expect(method_call).to include(ep100x5x3)
      expect(method_call).not_to include(ep200x6x2, ep100x5x2, ep100x1000mmx5x3)
    end
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
