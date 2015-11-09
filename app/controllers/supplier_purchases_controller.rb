class SupplierPurchasesController < ApplicationController

  def index
    # .includes([:supplier_orders, :orders, :offers, :quotes, :clients, :suppliers])
    @supplier_purchases = SupplierPurchase.where("supplier_purchases.reference <> ''")
      .includes([ {supplier_orders: :offer }, { offers: [:request] }, :quotes, :suppliers, :orders ])
      .where.not(supplier_orders: {id: nil})
      .order('supplier_purchases.id desc')

    if !params[:client_id].blank?
      @client = Client.find(params[:client_id])
      @supplier_purchases = @supplier_purchases.includes(:quotes, {quotes: :client}).where(quotes: {client_id: params[:client_id]})
    end

    if !params[:supplier_id].blank?
      @supplier_purchases = @supplier_purchases.includes(:suppliers).where(suppliers: {id: params[:supplier_id]})
    end

    @supplier_purchases = @supplier_purchases.page(params[:page]).per_page(40).decorate
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
    @supplier_purchase.address ||= @supplier_purchase.supplier_address
    if @supplier_purchase.ordered_at.nil?
      @supplier_purchase.ordered_at = Time.now
    end
  end

  def update
    @supplier_purchase = SupplierPurchase.find(params[:id])
    respond_to do |format|
      if @supplier_purchase.update_attributes(params[:supplier_purchase])
        @supplier_purchase.reindex
        @supplier_purchase.offers.map(&:update_total_prices)

        format.html { redirect_to @supplier_purchase, notice: 'Supplier Purchase was successfully updated.' }
        format.json { head :no_content }
      else
        @supplier_purchase = @supplier_purchase.decorate
        format.html { render action: "edit" }
        format.json { render json: @supplier_purchase.errors, status: :unprocessable_entity }
      end
    end
  end

end
