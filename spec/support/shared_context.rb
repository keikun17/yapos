RSpec.shared_context "AR Belt Product with 3 Vendor Items", :a => :b do
  # before { @some_var = :some_value }
  # def shared_method
  #   "it works"
  # end
  #
  # let(:shared_let) { {'arbitrary' => 'object'} }

  # subject do
  #   'this is the shared subject'
  # end

  let!(:product){ create(:ar_belt, name: "Abrasive Resistant Conveyor Belt")}
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

end
