require 'test_helper'

class OfferTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: offers
#
#  id                  :integer          not null, primary key
#  request_id          :integer
#  supplier_id         :integer
#  specs               :text
#  price               :float
#  currency            :string(255)
#  currency_conversion :float
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

