class OrdersController < ApplicationController

  before_filter :set_po_required_count, only: [:index, :services]
  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.includes(offers: [:client, :request, :invoices, :supplier_purchase]).all
    filter_orders_by_params_and_decorate
  end

  def services
    @orders = Order.with_service_offers
    filter_orders_by_params_and_decorate
  end

  def pending
    @orders = Order.with_supply_offers
    filter_orders_by_params_and_decorate
  end

  # TODO : Move this on its own controller
  def mass_update_si_and_dr
    @order = Order.find(params[:id])

    DrAndSiMassUpdater.update(
      @order,
      si_references: params[:offer][:invoices_attributes],
      dr_reference: params[:order][:dr_reference],
      delivery_date: params[:order][:delivery_date]
    )

    redirect_to @order, notice: "Order offers succesfully updated."
  end

  def print_delivery_monitoring
    @from_date = Time.zone.local(params[:print]['from_date(1i)'],
                                 params[:print]['from_date(2i)'],
                                 params[:print]['from_date(3i)']
                                ).beginning_of_day

    @to_date = Time.zone.local(params[:print]['to_date(1i)'],
                               params[:print]['to_date(2i)'],
                               params[:print]['to_date(3i)']
                              ).end_of_day

    @orders = Order.ordered.order("orders.purchase_date desc")
      .where(purchase_date: @from_date..@to_date)
      .order("orders.purchase_date desc")
      .decorate

    render layout: "printable"
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id]).decorate
    @quotes = @order.quotes.decorate
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id]).decorate
    @order.purchase_date ||= Time.zone.now
    @order.attachments.build if @order.attachments.empty?
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(params[:order])
    @order.purchase_selected_offers if @order.save
    respond_with(@order)
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])
    @order.purchase_selected_offers if @order.update_attributes(params[:order])
    @order = @order.decorate
    respond_with(@order)
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    respond_with(@order)
  end

  private

  def set_po_required_count
    po_required = Order.with_supply_offers
    if !params[:client_id].blank?
      @po_required_count = po_required.includes(:quotes).where(quotes: {client_id: params[:client_id]} ).count
    else
      @po_required_count = po_required.count
    end
  end

  def filter_orders_by_params_and_decorate
    if !params[:client_id].blank?
      @client = Client.find(params[:client_id])
      @orders = @orders.includes(:quotes).where(quotes: {client_id: params[:client_id]})
    end

    if !params[:supplier_id].blank?
      @orders = @orders.includes(:suppliers).where(suppliers: {id: params[:supplier_id]})
    end

    @orders = @orders.order("orders.purchase_date desc")
    @orders = @orders.page(params[:page]).per_page(40).decorate
  end

end
