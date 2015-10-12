class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
      .includes([:offers, :quotes, :clients, :payments])
      # .includes([:offers, :quotes, :orders, :clients, :payments])

    if !params[:client_id].blank?
      @invoices = @invoices.includes(:quotes).where(quotes: {client_id: params[:client_id]})
    end

    if !params[:supplier_id].blank?
      @invoices = @invoices.includes(:suppliers).where(suppliers: {id: params[:supplier_id]})
    end

    @invoices = @invoices.page(params[:page]).per_page(50).decorate
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
