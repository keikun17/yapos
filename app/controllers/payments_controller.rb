class PaymentsController < ApplicationController

  def index
    @payments = Payment.all.page(params[:page]).per_page(40)
  end

  def unpaid_orders

  end

  def show
    @payment = Payment.find(params[:id]).decorate
  end


end
