require 'rails_helper'

describe Quote, type: :model do
  subject(:quote) { Quote.new(status: "Pending") }

  describe "display_status" do
    subject { quote.display_status }

    context "a purchased offer exists" do
      before(:example) { quote.stub_chain(:offers, :purchased, :empty?).and_return(false) }
      it { is_expected.to match /Awarded/ }
    end

    context "a purchased offer does not exist" do
      before(:example) { quote.stub_chain(:offers, :purchased, :empty?).and_return(true) }
      it { is_expected.to eq(quote.status)}
    end

  end
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
