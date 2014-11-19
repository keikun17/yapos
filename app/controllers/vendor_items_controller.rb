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

    ######################################################################
    # TODO move to a PORO / Service
    ######################################################################
    #
    # If request is coming from ajax form
    if params[:vendor_item][:vendor_item_fields_attributes]["0"]
      vendor_item_values = params[:vendor_item][:vendor_item_fields_attributes].values
      vendor_item_fields = []
      vendor_item_values.each do |v|
        vendor_item_fields << {vendor_item_fields: v}
      end
    end

    # find_with_fields returns records that are 'read-only' so we have to do
    # this:
    read_only_vendor_item = VendorItem.find_with_fields(vendor_item_fields).first

    if read_only_vendor_item.nil?
      @vendor_item = VendorItem.new(params[:vendor_item])
    else
      @vendor_item = VendorItem.find(read_only_vendor_item)
    end

    ######################################################################
    # TODO-END (move to a PORO / Service)
    ######################################################################

    respond_to do |format|
      if @vendor_item.save
        @vendor_items = VendorItem.all

        format.html { redirect_to [@vendor_item.product, @vendor_item], notice: 'Vendor item was successfully created.' }
        format.json { render json: @vendor_item.to_json(methods: :csv) }
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
