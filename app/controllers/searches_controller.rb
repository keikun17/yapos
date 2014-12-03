class SearchesController < ApplicationController

  def search
    @type = params[:search][:type]
    unless params[:search][:string].blank?
      case params[:search][:type]
      when 'quote'
        @results = Quote.search(params[:search][:string]).records
      when 'order'
        @results = Order.search(params[:search][:string]).records
      else

      end
    else
      @results = []
    end

    # @results = SearchResult.decorate_collection(@results)
    @results
  end

  def search_vendor_item

  end

  def vendor_item_search_results

  end

  def product_select_for_search
    @product = Product.find(params[:product_id])
    @vendor_item = VendorItem.initialize_fields(@product)

    respond_to do |format|
      format.html
      format.js
    end
  end

end
