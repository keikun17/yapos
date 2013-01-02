module OrdersHelper
  def display_quotes(order)
    str = order.quotes.map{|quote| link_to(quote.quote_reference, quote_path(quote)) }.join(', ')
    raw str
  end
end
