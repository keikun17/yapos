class InvoiceDecorator < ApplicationDecorator

  def display_amount
    h.number_to_currency(self.amount || 0, unit: Currency::LOCAL_CURRENCY) if self.amount
  end

  def display_date
    invoice_date.to_date.to_s(:long) if invoice_date
  end
end

