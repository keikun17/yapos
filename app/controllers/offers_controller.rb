class OffersController < ApplicationController

  def index

    if params[:client_id].present?
      @client = Client.find(params[:client_id])
      @offers = @client.offers
    else
      @offers = Offer.all
    end

    @offers = @offers.order(created_at: :desc).paginate(page: params[:page], per_page: 40).decorate
  end

  def quick_purchase
    @offer = Offer.find(params[:id])

    if !params[:offer][:order_reference].blank?
      if @offer.update_attributes(params[:offer])

        # Create SupplierOrder
        Purchase.make([@offer])

        # Set Order date to current date
        @offer.order.update_attributes(purchase_date: Time.now)

        @offer.supplier_order.update_attributes(params['post_save']['supplier_order'])

        # Create SupplierPurchase with
        @offer.purchase_from_supplier

        redirect_to :back, notice: "Offer's PO number successfully updated"
      else
        redirect_to :back, action: 'show', error: "Offer record invalid."
      end
    else
      redirect_to :back, alert: "Error. Please enter a PO number"
    end

  end

  def update
    @offer = Offer.find(params[:id])

    respond_to do |format|
      if @offer.update_attributes(params[:offer]) and @offer.purchase_from_supplier
        format.html { redirect_to :back, notice: 'Offer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to back action: "edit" , error: 'Error. Record invalid'}
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  def vendor_code_update
    @offer = Offer.find(params[:id])

    vendor_item = case params[:vendor_item_code_is]
                       when "existing"
                         VendorItem.find_by(product_id: params[:product_id], code: params[:existing_vendor_code])
                       when "new"
                         @product = Product.find params[:product_id]
                         VendorItem.find_or_create_with_initialized_fields_by(code: params[:new_vendor_code], product_id: params[:product_id])
                       else
                         nil
                       end

    respond_to do |format|
      if !vendor_item.nil? && @offer.update({vendor_item_code: vendor_item.code})
        format.html { redirect_to :back, notice: 'Offer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to back action: "edit" , error: 'Error. Record invalid'}
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end
end
