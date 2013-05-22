class SupplierPurchasesController < ApplicationController

  def index
    @supplier_purchases = SupplierPurchase.order('ordered_at desc')
    @supplier_purchases = @supplier_purchases.order('ordered_at is null desc')
    @supplier_purchases = @supplier_purchases.paginate(page: params[:page], per_page: 20)
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
