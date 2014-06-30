class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.ordered
    @orders = @orders.order("orders.purchase_date desc")
    @orders = @orders.paginate(:page => params[:page], :per_page => 10)

    @decorated_orders = OrderDecorator.decorate_collection(@orders.to_a)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  def pending
    @orders = Order.not_yet_ordered
    @orders = @orders.order("orders.purchase_date desc")
    @orders = @orders.paginate(per_page: 20, page: params[:page])
    @decorated_orders = OrderDecorator.decorate_collection(@orders)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])
    @order = OrderDecorator.new(@order)

    @quotes = QuoteDecorator.decorate_collection(@order.quotes)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    @order = Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id]).decorate
    @order.purchase_date ||= Time.now
    @order.attachments.build if @order.attachments.empty?
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(params[:order])

    respond_to do |format|
      if @order.save and @order.purchase_selected_offers
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render json: @order, status: :created, location: @order }
      else
        format.html { render action: "new" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order]) and @order.purchase_selected_offers
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end


end
