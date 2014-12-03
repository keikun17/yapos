$ ->

  ######################################################################
  # Dynamic Vendor Item Search by Product
  ######################################################################

  $(document).on 'change', "#product_select_for_search", (evt) ->

    product_id = evt.target.value

    $.ajax "search/product_select_for_search.js",
      type: 'GET',
      data:
        product_id: "#{product_id}",
      dataType: 'script',
      error: (jqXHR, textStatus, errorThrown) ->
        console.log "Error retrieving vendor items"
        console.log "jqXHR is "
        console.log jqXHR

        console.log "textStatus is"
        console.log textStatus

        console.log "errorThrown is"
        console.log errorThrown

        success: (data, textStatus, jqXHR) ->
        # NOTE : NO NEED TO DO STUFF HERE BECAUSE THE RESPONSE IS 'application/js'
        # that executes things instead

    console.log("Product ID selected, retrieving form")
