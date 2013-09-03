class SupplierPurchasesController < ApplicationController

  def index
    @supplier_purchases = SupplierPurchase.where("supplier_purchases.reference <> ''")
    @supplier_purchases = @supplier_purchases.includes(:supplier_orders).where('supplier_orders.id is not null')
    @supplier_purchases = @supplier_purchases.order('supplier_purchases.ordered_at desc')
    @supplier_purchases = @supplier_purchases.order('supplier_purchases.ordered_at is null desc')
    @supplier_purchases = @supplier_purchases.paginate(page: params[:page], per_page: 40)
    @decorated_supplier_purchases = SupplierPurchaseDecorator.decorate_collection(@supplier_purchases)
  end

  def print
    @supplier_purchase = SupplierPurchase.find(params[:id])
    @supplier_purchase = SupplierPurchaseDecorator.new(@supplier_purchase)
    @print_preview = true
  end

  def edit
    @supplier_purchase = SupplierPurchase.find(params[:id])
    @supplier_purchase = SupplierPurchaseDecorator.new(@supplier_purchase)
    if @supplier_purchase.ordered_at.nil?
      @supplier_purchase.address = @supplier_purchase.supplier_address
      @supplier_purchase.ordered_at = Time.now
    end
  end

  def update
    @supplier_purchase = SupplierPurchase.find(params[:id])
    respond_to do |format|
      if @supplier_purchase.update_attributes(params[:supplier_purchase])
        format.html { redirect_to supplier_purchases_path, notice: 'Supplier Purchase was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

end
