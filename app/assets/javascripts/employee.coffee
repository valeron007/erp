$ ->

  if $('#employee_felony_false').prop('checked')
    $('.employee_felony_notes_wrapper').hide()
  else
    $('.employee_felony_notes_wrapper').show()


  $('input[name="employee[felony]"]').on 'click', (e) ->
    if($(this).val() == 'true')
      $('.employee_felony_notes_wrapper').show()
    else
      $('.employee_felony_notes_wrapper').hide()

  $(document).on 'change', '#employee_avatar', (e) ->
    $('#upload_form').submit()

  $('#crop_submit').on 'click', (e) ->
    $('#crop_form').submit()
