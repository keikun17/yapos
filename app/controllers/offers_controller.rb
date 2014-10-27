class OffersController < ApplicationController
  def purchase
    @offer = Offer.find(params[:id])

    respond_to do |format|
      if params[:offer][:order_reference]
        if @offer.update_attributes(params[:offer]) and Purchase.make([@offer])
          format.html { redirect_to :back, notice: "Offer's PO number successfully updated" }
        else
          format.html { redirect_to :back, action: 'show', error: "Offer record invalid." }
        end
      else
        format.html { redirect_to back, error: "Error. Please enter a PO number" }
        format.json { head :no_content }
      end
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
end
