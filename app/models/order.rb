class Order < ActiveRecord::Base
  attr_accessible :purchase_date, :reference, :quotes_attributes, :quotes

  has_many :quotes
  accepts_nested_attributes_for :quotes

  def associate_with_quotes(quotes)
    quotes.each do |quote|
      quote.update_attributes(:order_id => self.id)
    end
  end

end
