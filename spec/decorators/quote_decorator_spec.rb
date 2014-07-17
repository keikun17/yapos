require 'rails_helper'

describe QuoteDecorator, type: :decorator do

  before(:example) { |ex| puts ex.quantity}

  let(:example_description) { |ex| ex.status }

  it "accesses the example" do |ex|
    puts ex
  end

end

