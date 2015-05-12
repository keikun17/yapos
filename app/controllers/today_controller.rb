class TodayController < ApplicationController
  def show
    @quotes = Quote.today.decorate
    @orders = Order.today.decorate
  end
end
