class OffersController < ApplicationController
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

    respond_to do |format|
      if @offer.update_attributes(params[:offer])
        format.html { redirect_to :back, notice: 'Offer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to back action: "edit" , error: 'Error. Record invalid'}
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end
end
