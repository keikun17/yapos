class ProductFieldsController < ApplicationController
  before_action :set_product_field, only: [:show, :edit, :update, :destroy]

  # GET /product_fields
  def index
    @product_fields = ProductField.all
  end

  # GET /product_fields/1
  def show
  end

  # GET /product_fields/new
  def new
    @product_field = ProductField.new
  end

  # GET /product_fields/1/edit
  def edit
  end

  # POST /product_fields
  def create
    @product_field = ProductField.new(params[:product_field])

    if @product_field.save
      redirect_to @product_field, notice: 'Product field was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /product_fields/1
  def update
    if @product_field.update(params[:product_field])
      redirect_to @product_field, notice: 'Product field was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /product_fields/1
  def destroy
    @product_field.destroy
    redirect_to product_fields_url, notice: 'Product field was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_field
      @product_field = ProductField.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_field_params
      params.require(:product_field).permit(:name, :unit, :product_id, :field_type)
    end
end
