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
end
