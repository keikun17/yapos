class CreateSupplierPurchasesTable < ActiveRecord::Migration
  def change
    create_table :supplier_purchases do |t|
      t.references :order
      t.string :reference

      t.string  :recipient, :string
      t.string :address, :string

      t.text  :delivery
      t.text  :price_basis
      t.text  :remarks
      t.text  :terms
      t.text  :warranty

      t.datetime :ordered_at

      t.timestamp
    end

    add_index :supplier_purchases, :order_id
    add_index :supplier_purchases, :reference

    Offer.where('order_reference is not null').all.each do |offer|
      unless offer.supplier_order.reference.blank?
        a = offer.order.supplier_purchases.find_or_create_by_reference(offer.supplier_order.reference)
        puts a.inspect
      else
        puts "Offer#{offer.id} has no supplier order record!"
        puts offer.inspect
        puts "-----"
      end
    end

  end
end
