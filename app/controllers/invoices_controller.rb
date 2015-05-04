class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all.page(params[:page]).per_page(50).decorate
  end

  def show
    @invoice = Invoice.find(params[:id]).decorate
  end

  def edit
    @invoice = Invoice.find(params[:id]).decorate
  end

  def update
    @invoice = Invoice.find(params[:id]).decorate
    @invoice.update_attributes(params[:invoice])

    respond_with(@invoice)
  end
end
