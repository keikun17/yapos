require 'spec_helper'
puts "Here"

describe QuoteDecorator do

  before(:example) { |ex| puts ex.quantity}

  let(:example_description) { |ex| ex.status }

  it "accesses the example" do |ex|
    puts ex
  end

end

