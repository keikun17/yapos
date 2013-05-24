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
#  buying_price        :float
#  selling_price       :float
#  currency            :string(255)
#  currency_conversion :float
#  order_reference     :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  remarks             :text
#  terms               :string(255)
#  delivery            :string(255)
#  warranty            :string(255)
#  price_vat_status    :string(255)
#  total_buying_price  :float
#  total_selling_price :float
#  price_basis         :string(255)
#  summary             :string(255)
#

