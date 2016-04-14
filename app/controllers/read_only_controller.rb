class ReadOnlyController < ApplicationController

  #TODO : ADD TESTS FOR THIS VIEW
  def index
    @orders = Order.with_offers.order(created_at: :desc).limit(200)
  end
end
