# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->

  ######################################################################
  # Submit Parent form
  ######################################################################

  $(document).on 'click', "a[tb_submit_inner_form]", (evt) ->
    evt.preventDefault()

    parent_form = $(evt.target).parents('form')[0]

    $.ajax(
      url: parent_form.action,
      type: parent_form.method,
      data: $(parent_form).serialize(),
      success: (data, textStatus, jqXHR) ->
        # console.log "success yo!"
        # console.log "data is"
        # console.log data
        # console.log "textStatus is"
        # console.log textStatus
        # console.log "jqXHR is"
        # console.log jqXHR

        $(evt.target).parents('.offer-line').find('*[tb_vendor_item_id_field]').val(data.id)
        $(evt.target).parents('.offer-line').find('*[tb_vendor_item_code_field]').val(data.csv)
        $('.modal:visible').modal('hide')

      error: (jqXHR, textStatus, errorThrown) ->
        console.log "ERROR YO"
        console.log "jqXHR is"
        console.log jqXHR
        console.log "textStatus is "
        console.log textStatus
        console.log "errorThrown is"
        console.log errorThrown
    )




  ######################################################################
  # Select Product ID to render Vendor Item Form with Vendor Item Fields
  ######################################################################

  # checking for #[tb_render_form] is ugly.
  $(document).on 'change', "*[tb_render_form]", (evt) ->

    product_id = evt.target.value

    $.ajax "/products/#{product_id}/vendor_items/new.js",
      type: 'GET',
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

  ######################################################################
  # Show nearest modal
  ######################################################################
  $(document).on 'click', "a[tb_shows_nearest_modal='true']", (evt) ->
    $(evt.target).next('.modal').modal('show')

  ######################################################################
  # Focus on product ID field when modal appears
  ######################################################################
  $(".vendor_code_modal").on 'shown', ->
    $('vendor_item_product_id:visible').focus()

  ######################################################################
  # Quick copy
  ######################################################################
  $("form").on "click", '[data-field-group]',(e) ->

    # find link's siblings field whose data will be copied
    button =  $(e.target)
    fieldGroup = button.data('fieldGroup')
    field = button.parents('.controls').first().find("input[data-field-group='#{fieldGroup}']").first()

    console.log button

    # find target fields with the same supplier
    supplierId = button.parents(".fields").find("select[name*='supplier_id']").val()
    console.log supplierId

    same_supplier_fields = $("option[value='#{supplierId}']:selected").parent("select[name*='supplier_id']")
    target_fields = same_supplier_fields.parents('.fields').find("input[data-field-group='#{fieldGroup}']")

    # copy the value over to those fields with the same supplier
    target_fields.val(field.val())

    return false

