class SearchResult < Decorator

  def to_s
    case _type
    when "quote"
      self.quote_reference
    end
  end

  def date
    case _type
    when "quote"
      self.quote_date.split('T').first
    end
  end

  def suppliers
    case _type
    when "quote"
      self.supplier_names.join(',')
    end
  end

  def client
    case _type
    when "quote"
      self.client_name
    end
  end

end
