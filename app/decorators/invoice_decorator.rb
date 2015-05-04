class InvoiceDecorator < ApplicationDecorator

  def display_amount
    h.number_to_currency(self.amount || 0, unit: Currency::LOCAL_CURRENCY) if self.amount
  end
end

