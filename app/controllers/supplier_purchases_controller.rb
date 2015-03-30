class SupplierPurchasesController < ApplicationController

  def index
    @supplier_purchases = SupplierPurchase.where("supplier_purchases.reference <> ''")
    @supplier_purchases = @supplier_purchases.includes(:supplier_orders).where.not(supplier_orders: {id: nil})
    @supplier_purchases = @supplier_purchases.order('supplier_purchases.id desc')
    @supplier_purchases = @supplier_purchases.paginate(page: params[:page], per_page: 80).decorate
  end

  def show
    @supplier_purchase = SupplierPurchase.find(params[:id]).decorate
  end

  def print
    @supplier_purchase = SupplierPurchase.find(params[:id]).decorate
    @print_preview = true
  end

  def edit
    @supplier_purchase = SupplierPurchase.find(params[:id]).decorate
    if @supplier_purchase.ordered_at.nil?
      @supplier_purchase.address = @supplier_purchase.supplier_address
      @supplier_purchase.ordered_at = Time.now
    end
  end

  def update
    @supplier_purchase = SupplierPurchase.find(params[:id]).decorate
    respond_to do |format|
      if @supplier_purchase.update_attributes(params[:supplier_purchase])
        @supplier_purchase.reindex
        format.html { redirect_to @supplier_purchase, notice: 'Supplier Purchase was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

end
