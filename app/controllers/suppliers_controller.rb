class SuppliersController < ApplicationController
  # GET /suppliers
  # GET /suppliers.json
  def index
    @suppliers = Supplier.all

    respond_with(@suppliers)
  end

  # GET /suppliers/1
  # GET /suppliers/1.json
  def show
    @supplier = Supplier.find(params[:id])
    @offers = @supplier.offers

    @offers = if only_pending_offers?
                @offers.pending_client_order.by_quote_date
              elsif only_client_purchased_offers?
                @offers.purchased.by_supplier_order_date
              else
                @offers.by_quote_date
              end

    @offers = OfferDecorator.decorate_collection(@offers)

    respond_with(@supplier)
  end

  # GET /suppliers/new
  # GET /suppliers/new.json
  def new
    @supplier = Supplier.new
    respond_with(@supplier)
  end

  # GET /suppliers/1/edit
  def edit
    @supplier = Supplier.find(params[:id])
  end

  # POST /suppliers
  # POST /suppliers.json
  def create
    @supplier = Supplier.new(params[:supplier])
    @supplier.save
    respond_with(@supplier)
  end

  # PUT /suppliers/1
  # PUT /suppliers/1.json
  def update
    @supplier = Supplier.find(params[:id])
    @supplier.update_attributes(params[:supplier])
    respond_with(@supplier)
  end

  # DELETE /suppliers/1
  # DELETE /suppliers/1.json
  def destroy
    @supplier = Supplier.find(params[:id])
    @supplier.destroy

    respond_with(@supplier)
  end

  private

  def only_pending_offers?
    params[:filter_offers].eql?('pending_offers')
  end

  def only_client_purchased_offers?
    params[:filter_offers].eql?('ordered_offers')
  end

end
