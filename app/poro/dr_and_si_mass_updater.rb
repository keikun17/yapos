class DrAndSiMassUpdater
  def self.update(order, si_references: [], dr_reference: '', delivery_date: {})

    if dr_reference.present?
      order.offers.supplies.update_all({delivery_receipt_reference: dr_reference})
    end

    if si_references.present?
      invoices = []

      si_references.each do |index, attributes|
        attributes.delete("_destroy")
        invoices << Invoice.find_or_create_by(attributes) unless attributes["reference"].blank?
      end

      invoices.uniq!

      order.offers.each do |offer|
        invoices = invoices - offer.invoices
        offer.invoices << invoices
        offer.save
      end
    end

    if delivery_date["(1i)"].present? and delivery_date["(2i)"].present? and delivery_date["(3i)"].present?
      date = Date.new delivery_date["(1i)"].to_i, delivery_date["(2i)"].to_i, delivery_date["(3i)"].to_i
      order.supplier_orders.update_all({delivered_at: date})
    end

    order
  end
end
