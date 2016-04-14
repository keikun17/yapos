class ReadOnlyController < ApplicationController
  def index
    @orders = Order.all.order(created_at: :desc).limit(200)
  end
end
