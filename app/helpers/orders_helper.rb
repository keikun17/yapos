module OrdersHelper
  def display_quotes(order)
    str = order.quotes.map.each do |quote|
      link_to(quote.quote_reference, quote_path(quote)) 
    end
    str << order.custom_quote_reference if order.custom_quote_reference.present?
    str = str.join(', ')
    raw str
  end

  def link_to_order(order)
    h link_to(order.reference, order_path(order)) if order
  end

end
