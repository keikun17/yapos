require 'delegate'

class Decorator < SimpleDelegator

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

end
