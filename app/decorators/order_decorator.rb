class OrderDecorator < ApplicationDecorator

  delegate_all
  decorates_association :offers

  def decorated_offers
    @decorated_offers ||= offers.decorate
  end

  def display_purchase_date(warn: true)
    if purchase_date.nil?

      if warn
        str = h.content_tag :i do
          h.link_to "Please Complete Order Form", h.edit_order_path(self)
        end
        str = str.html_safe
      end

    else
      str = purchase_date.to_date
    end

    str
  end

  def supplier_links
    links = []
    suppliers.each do |supplier|
      links << h.link_to(supplier.name, h.supplier_path(supplier))
    end
    links.join(',').html_safe
  end

  def client_links
    links = []
    clients.each do |client|
      links << h.link_to(client.name, h.client_path(client))
    end
    links.join(',').html_safe
  end

  def link
    (h.link_to reference, h.order_path(self), class: 'reference  reference-order').html_safe
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
    h.number_to_currency(total_buy, unit: Currency::LOCAL_CURRENCY)
  end

  def display_total_sell
    h.number_to_currency(total_sell, unit: Currency::LOCAL_CURRENCY)
  end

  def display_total_profit
    h.number_to_currency(total_profit, unit: Currency::LOCAL_CURRENCY)
  end

end
