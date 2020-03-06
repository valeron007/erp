(($) ->

  $.fn.modal_success = ->
    # close modal
    @modal 'hide'
    # clear form input elements
    @find('form input[type="text"], form input[type="number"]').val ''
    # clear error state
    @clear_previous_errors()
    return

  $.fn.render_form_errors = (errors) ->
    $form = this
    @clear_previous_errors()
    model = @data('model')
    $.each errors, (field, messages) ->
      $input = $('input[name="' + model + '[' + field + ']"]')
      $input.closest('.form-group').addClass('has-error').find('.help-block').html messages.join(' & ')
      return
    return

  $.fn.clear_previous_errors = ->
    $('.form-group.has-error', this).each ->
      $('.help-block', $(this)).html ''
      $(this).removeClass 'has-error'
      return
    return

  return
) jQuery

$ ->
  $('select')
    .select2
      language: "ru"
      minimumResultsForSearch: 10
      allowClear: true
      placeholder: "Выбрать значение"

  $('.clockpicker')
    .clockpicker
      autoclose: true

  $('.multiselect2').each (i, e) =>
    select = $(e)
    options =
      language: "ru"
      placeholder: select.data('placeholder')
      allowClear: true
      templateResult: (option, container) ->
        $(container).addClass('bg-red') unless $(option.element).data('active')
        option.text
      dropdownCssClass: 'bigdrop'
    select.select2(options)
    
  $('.select2-tags')
  .select2
      language: "ru"
      minimumResultsForSearch: 0
      allowClear: true
      placeholder: "Выбрать значение"
      tags: true
      createTag: (params) ->
        term = $.trim(params.term)
        return null if term == ''
        return {
          id: term
          text: term
          newTag: true
        }    
  
  $('.autoselect2').each (i, e) =>
    select = $(e)
    options =
      language: "ru"
      placeholder: select.data('placeholder')
      minimumInputLength: 2
      allowClear: true
      ajax:
        url: select.data('source')
        dataType: 'json'
        delay: 250
        data: (params) ->
          q: params.term
        processResults: (data, params) ->
          results: data.resources
      templateResult: (data, container) ->
        $(container).addClass('bg-red') unless data.is_active
        data.text
      dropdownCssClass: 'bigdrop'
    select.select2(options)

  $('.datepicker')
    .datepicker
      format: 'dd.mm.yyyy'
      todayHighlight: true
      weekStart: 1
      language: "ru"
      autoclose: true

  $('#modal-submit').on 'click', ->
    $(this).closest('form').submit();

  $('form#new_position').bind 'ajaxError', (event, jqxhr, settings, exception) ->
    $(event.data).render_form_errors $.parseJSON(jqxhr.responseText)

  $(document).on 'change', '#per_page_select', ->
    url = $(@).find(':selected').data('url')
    sign = '&'
    sign = '?' if url.indexOf('?')==-1
    window.location.href = url + sign  + 'per_page=' + $(@).val()

  $(document).on 'click', '[data-toggle="lightbox"]',(event) ->
    event.preventDefault()
    $(this).ekkoLightbox()
  