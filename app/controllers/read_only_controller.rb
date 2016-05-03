class ReadOnlyController < ApplicationController

  #TODO : ADD TESTS FOR THIS VIEW
  def index
    @orders = Order.includes(:clients, offers: [:request, :supplier_purchase, :supplier, :supplier_order ]).
      with_offers.order(created_at: :desc).limit(50)
    filter_orders_by_params
  end

  private

  def filter_orders_by_params
    if !params[:client_id].blank?
      @client = Client.find(params[:client_id])
      @orders = @orders.includes(:quotes).where(quotes: {client_id: params[:client_id]})
    end

    if !params[:supplier_id].blank?
      @orders = @orders.includes(:suppliers).where(suppliers: {id: params[:supplier_id]})
    end

  end
end
