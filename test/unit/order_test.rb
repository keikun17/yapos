require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: orders
#
#  id                     :integer          not null, primary key
#  reference              :string(255)
#  purchase_date          :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  custom_quote_reference :string(255)
#  description            :text
#  supplier_id            :integer
#  client_id              :integer
#

