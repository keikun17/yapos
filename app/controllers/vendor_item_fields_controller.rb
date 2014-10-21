class VendorItemFieldsController < ApplicationController
  before_action :set_vendor_item_field, only: [:show, :edit, :update, :destroy]

  # GET /vendor_item_fields
  def index
    @vendor_item_fields = VendorItemField.all
  end

  # GET /vendor_item_fields/1
  def show
  end

  # GET /vendor_item_fields/new
  def new
    @vendor_item_field = VendorItemField.new
  end

  # GET /vendor_item_fields/1/edit
  def edit
  end

  # POST /vendor_item_fields
  def create
    @vendor_item_field = VendorItemField.new(vendor_item_field_params)

    if @vendor_item_field.save
      redirect_to @vendor_item_field, notice: 'Vendor item field was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /vendor_item_fields/1
  def update
    if @vendor_item_field.update(vendor_item_field_params)
      redirect_to @vendor_item_field, notice: 'Vendor item field was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /vendor_item_fields/1
  def destroy
    @vendor_item_field.destroy
    redirect_to vendor_item_fields_url, notice: 'Vendor item field was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vendor_item_field
      @vendor_item_field = VendorItemField.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def vendor_item_field_params
      params.require(:vendor_item_field).permit(:vendor_item_id, :value, :product_field_id)
    end
end
