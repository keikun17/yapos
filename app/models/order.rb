class Order < ActiveRecord::Base
  attr_accessible :purchase_date, :reference, :quotes_attributes, :quotes,
    :custom_quote_reference

  has_many :quotes
  accepts_nested_attributes_for :quotes

  def clear_quotes
    self.quotes.update_all(:order_id => nil)
  end

  def associate_with_quotes(quotes)
    clear_quotes
    quotes.each do |quote|
      quote.update_attributes(:order_id => self.id)
    end
  end

end
