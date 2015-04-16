require 'test_helper'

class SupplierTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: suppliers
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  emails          :string(255)
#  contact_numbers :string(255)
#  address         :text(65535)
#
