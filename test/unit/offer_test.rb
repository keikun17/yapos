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
#  id                         :integer          not null, primary key
#  request_id                 :integer
#  supplier_id                :integer
#  specs                      :text
#  buying_price               :float(24)
#  selling_price              :float(24)
#  currency                   :string(255)
#  currency_conversion        :float(24)
#  order_reference            :string(255)
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  remarks                    :text
#  terms                      :string(255)
#  delivery                   :string(255)
#  warranty                   :string(255)
#  price_vat_status           :string(255)
#  total_buying_price         :float(24)
#  total_selling_price        :float(24)
#  price_basis                :string(255)
#  summary                    :string(255)
#  delivery_receipt_reference :string(255)
#  sales_invoice_reference    :string(255)
#  vendor_item_code           :string(255)
#  vendor_item_id             :string(255)
#  hide_supplier_in_print     :boolean
#  internal_notes             :text
#  buying_currency            :string(255)
#  service                    :boolean          default(FALSE)
#
