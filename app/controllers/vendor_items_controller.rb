class VendorItemsController < ApplicationController
  before_action :set_vendor_item, only: [:show, :edit, :update, :destroy]

  # GET /vendor_items
  def index
    @vendor_items = VendorItem.all
  end

  # GET /vendor_items/1
  def show
  end

  # GET /vendor_items/new
  def new
    @product = Product.find(params[:product_id])
    @vendor_item = VendorItem.initialize_fields(@product)

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /vendor_items/1/edit
  def edit
  end

  # POST /vendor_items
  def create
    @vendor_item = VendorItem.find_or_initialize_fields_by(params[:vendor_item])

    respond_to do |format|
      if @vendor_item.save
        @vendor_items = VendorItem.all

        format.html { redirect_to [@vendor_item.product, @vendor_item], notice: 'Vendor item was successfully created.' }
        format.js
      else
        format.html { render :action => "new", :layout => !request.xhr? }
      end
    end

  end

  # PATCH/PUT /vendor_items/1
  def update
    if @vendor_item.update_and_reindex_offers(params[:vendor_item])
      redirect_to price_movement_path(@vendor_item), notice: 'Vendor item was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /vendor_items/1
  def destroy
    @vendor_item.destroy
    redirect_to product_path(@product), notice: 'Vendor item was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vendor_item
      @product = Product.find(params[:product_id])
      @vendor_item = @product.vendor_items.find(params[:id])
    end

end
