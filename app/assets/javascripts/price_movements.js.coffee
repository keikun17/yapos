$ ->

  $(document).on 'change', "input[tb_toggles_visibility]", (evt) ->
    revealed = $(evt.target).attr('tb_toggles_visibility')
    console.log revealed
    $("*[tb_toggled_visibility]").addClass('hidden')
    $("*[tb_toggled_visibility='#{revealed}']").removeClass('hidden')

  # $(document).on 'change', '#vendor_item_code_is_new', (evt) ->
  #   $('#field_for_new_vendor_code:hidden').removeClass('hidden')
  #   $('#field_for_existing_vendor_code:visible').addClass('hidden')
  #
  # $(document).on 'change', '#vendor_item_code_is_existing', (evt) ->
  #   $('#field_for_existing_vendor_code:hidden').removeClass('hidden')
  #   $('#field_for_new_vendor_code:visible').addClass('hidden')
  #
  #
