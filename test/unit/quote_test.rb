require 'test_helper'

class QuoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: quotes
#
#  id                 :integer          not null, primary key
#  quote_date         :datetime
#  quote_reference    :string(255)
#  quantity           :float(24)
#  description        :text(65535)
#  status             :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  client_id          :integer
#  supplier_id        :integer
#  order_id           :integer
#  signatory          :string(255)
#  signatory_position :string(255)
#  contact_person     :string(255)
#  remarks            :text(65535)
#  internal_notes     :text(65535)
#  title              :text(65535)
#  blurb              :text(65535)
#
