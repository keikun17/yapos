require 'rails_helper'

describe QuoteDecorator, type: :decorator do

  subject { Quote.new(quote_reference: 'PR#123-456').decorate }


  describe "#display_reference" do
    it {}
  end

end

