class SearchResult

  def retrieve(model, search_params)
    model.search(search_params[:string])
  end

end
