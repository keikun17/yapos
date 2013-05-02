class SearchesController < ApplicationController

  def search
    case params[:search][:type]
    when 'quote'
      @results = Quote.search(params[:search][:string])
    when 'order'
      @results = Order.search(params[:search][:string])
    else

    end

    @results = SearchResult.decorate_collection(@results)
  end

end
