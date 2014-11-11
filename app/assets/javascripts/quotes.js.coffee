# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->

  ######################################################################
  # Select Product ID to render Vendor Item Form with Vendor Item Fields
  ######################################################################
  $(document).on 'change', "*[tb_render_form]", (evt) ->

    product_id = evt.target.value

    $.ajax "/products/#{product_id}/vendor_items/new",
      type: 'GET',
      dataType: 'json',
      error: (jqXHR, textStatus, errorThrown) ->
        console.log "Error retrieving vendor items"
        console.log "jqXHR is "
        console.log jqXHR

        console.log "textStatus is"
        console.log textStatus

        console.log "errorThrown is"
        console.log errorThrown

      success: (data, textStatus, jqXHR) ->
        console.log "Found stuff"


    console.log("Product ID selected, retrieving form")

  ######################################################################
  # Focus on product ID field when modal appears
  ######################################################################
  $('#vendor_code_form').on 'shown', ->
    $('vendor_item_product_id').focus()

  ######################################################################
  # Quick copy
  ######################################################################
  $("form").on "click", 'a[data-field-group]',(e) ->

    # find link's siblings field whose data will be copied
    button =  $(e.target)
    window.butt = button
    fieldGroup = button.data('fieldGroup')
    field = button.siblings("input[data-field-group='#{fieldGroup}']")

    console.log button

    # find target fields with the same supplier
    supplierId = button.parents(".fields").find("select[name*='supplier_id']").val()
    console.log supplierId

    same_supplier_fields = $("option[value='#{supplierId}']:selected").parent("select[name*='supplier_id']")
    target_fields = same_supplier_fields.parents('.fields').find("input[data-field-group='#{fieldGroup}']")

    # copy the value over to those fields with the same supplier
    target_fields.val(field.val())

    return false

