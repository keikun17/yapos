module QuotesHelper
  def supplier_links(quote)
    suppliers = quote.suppliers.to_a
    suppliers << quote.supplier
    suppliers.compact!
    suppliers.uniq!
    links = suppliers.collect do |supplier|
      link_to supplier.name, supplier_path(supplier) 
    end
    raw links.join(', ')
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
