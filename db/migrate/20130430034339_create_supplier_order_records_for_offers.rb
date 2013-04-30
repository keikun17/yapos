class CreateSupplierOrderRecordsForOffers < ActiveRecord::Migration
  def up
    Offer.all.each do |offer|
       if offer.supplier_order.nil? 
         offer.create_supplier_order
       end
    end
  end

  def down
    puts "Rather not roll data back"
  end
end
