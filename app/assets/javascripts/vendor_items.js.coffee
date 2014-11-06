# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
 
  #######################################################################
  # Dynamic Select for Product -> Vendor Item Code
  #######################################################################
  $(document).on 'change' ,"select[data-dynamic-select]:visible", (evt) ->
    console.log "parent select changed"

    child_select_selector = $(evt.target).data('dynamicSelect')

    child_select = $("select[data-dynamic-selected='#{child_select_selector}']:visible")
    child_select.empty()
    child_select.hide()

    product_id = evt.target.value

    $.ajax "/products/#{product_id}",
      type: 'GET',
      dataType: 'json',
      error: (jqXHR, textStatus, errorThrown) ->
        console.log "Error retrieving vendor items"
      success: (data, textStatus, jqXHR) ->
        console.log "Found stuff"

        response_collection = jqXHR.responseJSON

        $.each response_collection, (index, vendor_item) ->
          option = $("<option></option").attr("value", vendor_item.code).text(vendor_item.code)
          $(child_select).append(option)

        child_select.show()

        console.log "data is "
        console.log data
        console.log "jqXHR is "
        console.log jqXHR


