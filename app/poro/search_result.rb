require 'delegate'

class SearchResult < SimpleDelegator

  def class
    def class
      __get_obj__.class
    end
  end

  def self.decorate_collection(arr)
    decorated_collection = []
    arr.each do |item|
      decorated_collection << self.new(item)
    end
    decorated_collection
  end

  def to_s
    case _type
    when "quote"
      self.quote_reference
    end
  end
end
