class ClientDecorator < Decorator

  def quote_count
    decorated_object.quotes.count
  end

  def order_count
    decorated_object.orders.count
  end
end
