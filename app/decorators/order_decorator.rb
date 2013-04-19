class OrderDecorator < Decorator

  def display_purchase_date
    if purchase_date.nil?
      str = content_tag :i do
        "Please Fill Up"
      end
    else
      str = purchase_date.to_date
    end

    str
  end

  def link
    link_to reference, order_path(self)
  end

end
