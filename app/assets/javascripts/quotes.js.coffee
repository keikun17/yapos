# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $("form").on "click", 'button[data-field-group]',(e) ->

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

