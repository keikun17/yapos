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

  def total_buy
    offers.sum(:buying_price)
  end
  
  def total_sell
    offers.sum(:selling_price)
  end

  def total_profit
    total_sell - total_buy
  end

end
