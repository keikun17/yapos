module QuotesHelper
  def nav_pending_quote(path)
    text = content_tag(:span, 'Pending')
    counter = content_tag(:span, Quote.with_pending_requests.count, class: 'badge badge-important')
    text.safe_concat(' ')
    text.safe_concat(counter)
    link_to text, path
  end

  def supplier_links(quote)
    suppliers = quote.suppliers.uniq.to_a
    suppliers.collect do |supplier|
      link_to supplier.name, supplier_path(supplier) 
    end.join(', ').html_safe
  end

  def quote_row_class(quote)
    case quote.display_status
    when "Awarded"
      'success'
    when "Not Awarded"
      'error'
    when "Cancelled"
      'error'
    when "No Quote"
      'info'
    end
  end
end
