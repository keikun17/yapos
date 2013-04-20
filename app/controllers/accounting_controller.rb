class AccountingController < ApplicationController
  def index
    @orders = Order.all
    @orders = OrderDecorator.decorate_collection(@orders)
  end
end
