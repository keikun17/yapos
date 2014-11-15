require 'rails_helper'

RSpec.describe VendorItem, :type => :model do
  let(:product){ create(:ar_belt, name: "Abrasive Reistant Conveyor Belt")}

  context "Vendor Item with properties for 1000mm x EP100 x 4P x 3mm x 2mm" do
    subject(:vendor_item) { product.vendor_item.create(:code) { "PB - 1000mm x EP100 x 4P x 3mm x 2mm"} }

    let!(:field_width) { product.product_fields.find_by(name: 'width') }
    let!(:field_ep) { product.product_fields.find_by(name: 'EP') }
    let!(:field_top_cover) { product.product_fields.find_by(name: 'Top Cover') }
    let!(:field_bottom_cover) { product.product_fields.find_by(name: 'Bottom Cover ') }


    let!(:ep100x5x3) do
      v = product.vendor_items.new
      v.vendor_item_fields.build(product_field_id: field_ep.id, value: '100' )
      v.vendor_item_fields.build(product_field_id: field_top_cover.id, value: '5' )
      v.vendor_item_fields.build(product_field_id: field_bottom_cover.id, value: '3' )
      v.save!
      v
    end

    let!(:ep100x1000mmx5x3 ) do
      v = product.vendor_items.new
      v.vendor_item_fields.build(product_field_id: field_width.id, value: '1000' )
      v.vendor_item_fields.build(product_field_id: field_ep.id, value: '100' )
      v.vendor_item_fields.build(product_field_id: field_top_cover.id, value: '5' )
      v.vendor_item_fields.build(product_field_id: field_bottom_cover.id, value: '3' )
      v.save!
      v
    end

    let!(:ep100x5x2) do
      v = product.vendor_items.new
      v.vendor_item_fields.build(product_field_id: field_ep.id, value: '100' )
      v.vendor_item_fields.build(product_field_id: field_top_cover.id, value: '5' )
      v.vendor_item_fields.build(product_field_id: field_bottom_cover.id, value: '2' )
      v.save!
      v
    end


    let!(:ep200x6x2) do
      v = product.vendor_items.new
      v.vendor_item_fields.build(product_field_id: field_ep.id, value: '200' )
      v.vendor_item_fields.build(product_field_id: field_top_cover.id, value: '6' )
      v.vendor_item_fields.build(product_field_id: field_bottom_cover.id, value: '2' )
      v.save!
      v
    end

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
