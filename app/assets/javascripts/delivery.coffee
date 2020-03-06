$ ->

  $(document).on 'click', 'a.delivery-name-suggestion', (e) ->
    e.preventDefault()
    $('#delivery_name').val($(this).text())
    clearSuggestions()

  $('#delivery_name').on 'input', (e) ->
    clearSuggestions()
    $('.delivery-name-autocomplete').text("")
    if $(this).val().length >= 3
      fetch("/deliveries/autocomplete_name?name=" + $(this).val())
        .then((data) -> data.json())
        .then((arr) -> appendSuggestion(i) for i in arr)

  appendSuggestion = (s) ->
    $('.delivery-name-autocomplete').append("<li><a href='#' class='delivery-name-suggestion'>" + s + "</a></li>")

  clearSuggestions = () ->
    $('.delivery-name-autocomplete').text("")

  if $('#delivery_delivery_needed').prop('checked')
    $('.delivery-fields').show()
  else
    $('.delivery-fields').hide()


  $('#delivery_delivery_needed').on 'click', (e) ->
    if($(this).prop('checked'))
      $('.delivery-fields').show()
    else
      $('.delivery-fields').hide()

  $('form.simple_form').on 'keyup', '#delivery_count, #delivery_price_per_unit', (e) ->
    count = parseFloat($('#delivery_count').val())
    count = 0 if isNaN count
    price = parseFloat($('#delivery_price_per_unit').val())
    price = 0 if isNaN price
    $('#delivery_cost').val((count*price).toFixed(2))
  
  currentPopover = null
  $('body').popover
    selector: '.delivery_row',
    html: true,
    placement: 'auto'
    container: 'body'
    content: ->
      $.ajax({url: $(@).data('delivery-details-url'), async: false}).responseText

  $(document).on 'shown.bs.popover', (e) ->
    target = $(e.target)
    if currentPopover && currentPopover.get(0) != target.get(0)
      currentPopover.data('bs.popover').inState =
        click: false
        hover: false
        focus: false
      currentPopover.popover 'hide'
    currentPopover = target

  $(document).on 'hidden.bs.popover', (e) ->
    currentPopover = null if currentPopover && currentPopover.get(0) == $(e.target).get(0)    