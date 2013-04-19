require 'delegate'

class Decorator < SimpleDelegator
  include ActionView::Helpers
  include ActionView::Context
  include Rails.application.routes.url_helpers

  def self.decorate_collection(arr)
    decorated_collection = []
    arr.each do |item|
      decorated_collection << self.new(item)
    end
    decorated_collection
  end

end
