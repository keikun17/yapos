require 'rails_helper'

RSpec.describe VendorItem, :type => :model do
  let(:product){ create(:ar_belt, name: "Abrasive Reistant Conveyor Belt")}

  context "Vendor Item with properties for 1000mm x EP100 x 4P x 3mm x 2mm" do
    subject(:vendor_item) { product.vendor_item.create(:code) { "PB - 1000mm x EP100 x 4P x 3mm x 2mm"} }
    let(:field_width) { product.product_fields.find_by(name: 'width') }
    let(:field_ep) { product.product_fields.find_by(name: 'EP') }
    let(:field_top_cover) { product.product_fields.find_by(name: 'Top Cover') }
    let(:field_bottom_cover) { product.product_fields.find_by(name: 'Bottom Cover ') }

    describe "#find_with_fields" do

      it "Searching for 'EP100, 5 x 3' returns vendor items with the matching field attributes" do

        @ep100x5x3 = product.vendor_items.new
        @ep100x5x3.vendor_item_fields.build(product_field_id: field_ep.id, value: '100' )
        @ep100x5x3.vendor_item_fields.build(product_field_id: field_top_cover.id, value: '5' )
        @ep100x5x3.vendor_item_fields.build(product_field_id: field_bottom_cover.id, value: '3' )
        @ep100x5x3.save!


        @ep100x1000mmx5x3 = product.vendor_items.new
        @ep100x1000mmx5x3.vendor_item_fields.build(product_field_id: field_width.id, value: '1000' )
        @ep100x1000mmx5x3.vendor_item_fields.build(product_field_id: field_ep.id, value: '100' )
        @ep100x1000mmx5x3.vendor_item_fields.build(product_field_id: field_top_cover.id, value: '5' )
        @ep100x1000mmx5x3.vendor_item_fields.build(product_field_id: field_bottom_cover.id, value: '3' )
        @ep100x1000mmx5x3.save!

        @ep100x5x2 = product.vendor_items.new
        @ep100x5x2.vendor_item_fields.build(product_field_id: field_ep.id, value: '100' )
        @ep100x5x2.vendor_item_fields.build(product_field_id: field_top_cover.id, value: '5' )
        @ep100x5x2.vendor_item_fields.build(product_field_id: field_bottom_cover.id, value: '2' )
        @ep100x5x2.save!

        @ep200x6x2 = product.vendor_items.new
        @ep200x6x2.vendor_item_fields.build(product_field_id: field_ep.id, value: '200' )
        @ep200x6x2.vendor_item_fields.build(product_field_id: field_top_cover.id, value: '6' )
        @ep200x6x2.vendor_item_fields.build(product_field_id: field_bottom_cover.id, value: '2' )
        @ep200x6x2.save!

        method_call  = VendorItem.find_with_fields([
          {vendor_item_fields: {product_field_id: field_ep.id        , value: '100' }},
          {vendor_item_fields: {product_field_id: field_top_cover.id    , value: '5'}},
          {vendor_item_fields: {product_field_id: field_bottom_cover.id , value: '3' }}
        ])

        expect(method_call).to include(@ep100x5x3,@ep100x1000mmx5x3)
        expect(method_call).not_to include(@ep200x5x3, @ep100x5x2)
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
