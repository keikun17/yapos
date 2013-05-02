class SearchResult < Decorator

  def to_s
    case _type
    when "quote"
      self.quote_reference
    when "order"
      self.reference
    end
  end

  def date
    case _type
    when "quote"
      self.quote_date.split('T').first
    when "order"
      self.purchase_date.split('T').first
    end
  end

  def display_status
    case _type
    when "quote"
      __getobj__.display_status
    else
      "implement"
    end
  end

  def suppliers
    case _type
    when "quote", "order"
      self.supplier_names
    end
  end

  def client
    case _type
    when "quote"
      self.client_name
    when "order"
      self.client_names
    else
      "implement"
    end
  end

end
