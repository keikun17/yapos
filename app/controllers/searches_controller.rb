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

end
