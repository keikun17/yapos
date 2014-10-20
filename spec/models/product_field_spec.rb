require 'rails_helper'

RSpec.describe ProductField, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
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
