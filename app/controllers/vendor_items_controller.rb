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
    @vendor_item = VendorItem.new
  end

  # GET /vendor_items/1/edit
  def edit
  end

  # POST /vendor_items
  def create
    @vendor_item = VendorItem.new(vendor_item_params)

    if @vendor_item.save
      redirect_to @vendor_item, notice: 'Vendor item was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /vendor_items/1
  def update
    if @vendor_item.update(vendor_item_params)
      redirect_to @vendor_item, notice: 'Vendor item was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /vendor_items/1
  def destroy
    @vendor_item.destroy
    redirect_to vendor_items_url, notice: 'Vendor item was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vendor_item
      @vendor_item = VendorItem.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def vendor_item_params
      params.require(:vendor_item).permit(:code, :product_id)
    end
end
