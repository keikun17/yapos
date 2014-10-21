require 'rails_helper'

RSpec.describe VendorItem, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
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
