class Order < ActiveRecord::Base
  attr_accessible :purchase_date, :reference, :quotes_attributes, :quotes,
    :custom_quote_reference, :description, :client_id, :supplier_id

  has_many :quotes
  belongs_to :client
  belongs_to :supplier

  accepts_nested_attributes_for :quotes

  delegate :name, :to => :client, :allow_nil => true, :prefix => true
  delegate :name, :to => :supplier, :allow_nil => true, :prefix => true

  default_scope order('purchase_date desc')

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
