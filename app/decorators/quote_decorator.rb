class QuoteDecorator < Decorator
  def order_links
    links = OrderDecorator.decorate_collection(self.orders).collect(&:link)
    links.uniq!
    raw links.join(',')
  end

  def contact_person
    #TODO:IMPLEMENT
    content_tag :i do
      "Mr. Juan Dela Cruz"
    end
  end

  def signatory
    "Ress Magsipoc"
  end

  def signatory_position
    "Manager"
  end
end
