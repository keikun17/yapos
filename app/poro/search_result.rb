require 'delegate'

class SearchResult < SimpleDelegator

  def class
    __get_obj__.class
  end

  def self.decorate_collection(arr)
    decorated_collection = []
    arr.each do |item|
      decorated_collection << self.new(item)
    end
    decorated_collection
  end

  def description
    self._type
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

  def to_s
    case _type
    when "quote"
      self.quote_reference
    end
  end
end
