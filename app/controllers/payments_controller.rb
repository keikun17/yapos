class PaymentsController < ApplicationController

  def index
    @payments = Payment.all
      .includes([:offers, :quotes, :orders, :clients])

    if !params[:client_id].blank?
      @payments = @payments.includes(:quotes).where(quotes: {client_id: params[:client_id]})
    end

    if !params[:supplier_id].blank?
      @payments = @payments.includes(:suppliers).where(suppliers: {id: params[:supplier_id]})
    end

    @payments = @payments.page(params[:page]).per_page(40).decorate
  end

  def unpaid_orders

  end

  def show
    @payment = Payment.find(params[:id]).decorate
  end

  def edit
    @payment = Payment.find(params[:id]).decorate
  end

  def update
    @payment = Payment.find(params[:id]).decorate
    @payment.update_attributes(params[:payment])

    respond_with(@payment)
  end

end
