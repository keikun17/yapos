class SearchesController < ApplicationController

  def search
    unless params[:search][:string].blank?
      case params[:search][:type]
      when 'quote'
        @results = Quote.search(params[:search][:string])
      when 'order'
        @results = Order.search(params[:search][:string])
      else

      end
    else
      @results = []
    end

    @results = SearchResult.decorate_collection(@results)
  end

end
