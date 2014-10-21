require 'rails_helper'

RSpec.describe VendorItemField, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: vendor_item_fields
#
#  id               :integer          not null, primary key
#  vendor_item_id   :integer
#  value            :string(255)
#  product_field_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#
