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
