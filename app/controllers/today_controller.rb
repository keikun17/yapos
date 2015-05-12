class TodayController < ApplicationController
  def show
    @quotes = Quote.today.decorate
    @orders = Order.today.decorate
    @supplier_purchases = SupplierPurchase.today.decorate
  end
end
