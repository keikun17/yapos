module SuppliersHelper
  def link_to_supplier(supplier)
    h link_to(supplier.name, supplier_path(supplier)) if supplier
  end
end
