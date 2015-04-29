class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all.page(params[:page]).per_page(50)
  end
end
