class ReadOnlyController < ApplicationController

  #TODO : ADD TESTS FOR THIS VIEW
  def index
    @orders = Order.includes(:clients, offers: [:request, :supplier_purchase, :supplier, :supplier_order ]).
      with_offers.order(created_at: :desc).limit(70)
  end
end
