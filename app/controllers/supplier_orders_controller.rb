class SupplierOrdersController < ApplicationController
  def update
    @supplier_order = SupplierOrder.find(params[:id])

    respond_to do |format|
      if @supplier_order.update_attributes(params[:supplier_order])
        format.html { redirect_to :back, notice: 'Supplier Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to :back, action: "edit" , error: 'Error. Record invalid'}
        format.json { render json: @supplier_order.errors, status: :unprocessable_entity }
      end
    end
  end
end
