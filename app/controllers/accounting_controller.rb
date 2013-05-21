class AccountingController < ApplicationController
  def index
    @orders = Order.order('purchase_date is null desc, purchase_date desc')
    @orders = OrderDecorator.decorate_collection(@orders)
    @total_profit = Purchase.display_total_profit
  end
end
