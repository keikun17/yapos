class OffersController < ApplicationController
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
