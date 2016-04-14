class ReadOnlyController < ApplicationController
  def index
    @orders = Order.with_offers.order(created_at: :desc).limit(200)
  end
end
