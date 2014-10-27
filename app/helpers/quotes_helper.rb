module QuotesHelper
  def supplier_links(quote)
    suppliers = quote.suppliers.uniq.to_a
    suppliers.collect do |supplier|
      link_to supplier.name, supplier_path(supplier)
    end.join(', ').html_safe
  end

  def quote_row_class(quote)
    status = case quote.display_status
    when "Awarded"
      'success'
    when "Not Awarded"
      'error'
    when "Cancelled"
      'error'
    when "No Quote"
      'info'
    else
      ''
    end

    row_class = 'multi-content ' +  status

  end
end
