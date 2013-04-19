module OrdersHelper
  def display_quotes(order)
    str = order.quotes.map.each do |quote|
      link_to(quote.quote_reference, quote_path(quote)) 
    end
    str << order.custom_quote_reference if order.custom_quote_reference.present?
    str = str.join(', ')
    raw str
  end

  def client_names(order)
    client_names = order.quotes.map(&:client_name)
    client_names << order.client_name
    client_names.compact.join(', ')
  end

end
