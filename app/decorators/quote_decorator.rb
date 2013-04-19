class QuoteDecorator < Decorator
  def order_links
    links = OrderDecorator.decorate_collection(self.orders).collect(&:link)
    raw links.join(',')
  end
end
