class OrderDecorator < Decorator

  attr_accessor :total_buy
  attr_accessor :total_sell

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

  def supplier_links
    links = []
    suppliers.each do |supplier|
      links << link_to(supplier.name, supplier_path(supplier.name))
    end
    raw links.join(',')
  end

  def client_links
    links = []
    clients.each do |client|
      links << link_to(client.name, client_path(client.name))
    end
    raw links.join(',')
  end

  def link
    link_to reference, order_path(self)
  end

  def total_buy
    @total_buy ||= offers.sum(:total_buying_price)
  end
  
  def total_sell
    @total_sell ||= offers.sum(:total_selling_price)
  end

  def total_profit
    total_sell - total_buy
  end

  def display_total_buy
    Currency::LOCAL_CURRENCY + " " + total_buy.to_s
  end

  def display_total_sell
    Currency::LOCAL_CURRENCY + " " + total_sell.to_s
  end

  def display_total_profit
    Currency::LOCAL_CURRENCY + " " + total_profit.to_s
  end

end
