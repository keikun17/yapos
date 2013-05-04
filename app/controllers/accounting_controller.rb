class AccountingController < ApplicationController
  def index
    @orders = Order.all
    @orders = OrderDecorator.decorate_collection(@orders)
    @total_profit = Purchase.display_total_profit
  end
end
