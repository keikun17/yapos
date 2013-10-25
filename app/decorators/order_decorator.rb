class OrderDecorator < ApplicationDecorator

  def decorated_offers
    @decorated_offers ||= OfferDecorator.decorate_collection(self.offers)
  end

  def display_purchase_date
    if purchase_date.nil?
      str = content_tag :i do
        link_to "Please Fill Up", edit_order_path(self)
      end
    else
      str = purchase_date.to_date
    end

    str
  end

  def supplier_links
    links = []
    suppliers.each do |supplier|
      links << link_to(supplier.name, supplier_path(supplier))
    end
    raw links.join(',')
  end

  def client_links
    links = []
    clients.each do |client|
      links << link_to(client.name, client_path(client))
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
    number_to_currency(total_buy, unit: Currency::LOCAL_CURRENCY)
  end

  def display_total_sell
    number_to_currency(total_sell, unit: Currency::LOCAL_CURRENCY)
  end

  def display_total_profit
    number_to_currency(total_profit, unit: Currency::LOCAL_CURRENCY)
  end

end
