class SearchResult < Decorator

  def to_s
    case _type
    when "quote"
      self.quote_reference
    when "order"
      self.reference
    end
  end

  #FIXME : Use Inheritance
  def date
    case _type
    when "quote"
      self.quote_date.split('T').first if !self.quote_date.nil?
    when "order"
      self.purchase_date.split('T').first if !self.purchase_date.nil?
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

  def quoted_items
    case _type
    when "quote"
      requests = self.load.requests.decorate

      requests.collect do |request|
        content_tag :span do
          quantity = content_tag :span do
            request.to_label('label label-info')
          end
          desc = content_tag :span do
            request.specs
          end
          safe_join([quantity, desc])
        end
      end.join.html_safe

      # request_html = content_tag :div do
      #   inner = requests.each do |request|
      #      content_tag :span do
      #        request.display_quantity
      #      end
      #      content_tag :span do
      #        request.specs
      #      end
      #      content_tag :br
      #   end
      #
      #   inner
      # end
      # request_html
    when "order"
      "Implement"
    else
      "implement"
    end

  end

end
