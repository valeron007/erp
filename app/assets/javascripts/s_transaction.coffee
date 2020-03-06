$ ->
  currentPopover = null
  $(document).on 'click', '.transaction_row', (e) ->
    if !$(e.target).closest('td').is('.no-popover')
      t = $(e.target).closest('tr')
      t.popover
        html: true,
        placement: 'auto'
        container: 'body'
        content: ->
          $.ajax({url: $(@).data('transaction-details-url'), async: false}).responseText
      t.popover('show')

  $('select.s-tool').change (e) =>
    if e.target.value
      renderToolLocation(e.target.value, e.target.parentNode.childNodes[4])

  renderToolLocation = (id, node) =>
    $.ajax
      url: "/s_tools/#{id}/get_current_location"
      type: "GET"
      datatype: "json"
      success: (d) => node.textContent = "Текущее местоположение: #{d.location}"

  $('select.s-tool').trigger("change")

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

  $(document).on 'click', (e) ->
    $('.transaction_row').popover 'hide' if $(e.target).parents('.transaction_row').length == 0

  $(".radio_buttons").change ->
    if $('#s_transaction_operation_type_income').prop("checked")
      $('.s-tools-fields').show()
      $('.s_transaction_destination').hide()
      $('.s_transaction_source').show();
    if $('#s_transaction_operation_type_outcome').prop("checked")
      $('.s-tools-fields').show()
      $('.s_transaction_source').hide()
      $('.s_transaction_destination').show()
    if $('#s_transaction_operation_type_transfer').prop("checked")
      $('.s-tools-fields').show()
      $('.s_transaction_destination').show()
      $('.s_transaction_source').show()
    if $('#s_transaction_operation_type_entrance').prop("checked")
      $('.s-tools-fields').hide()
      $('.s_transaction_destination').hide()
      $('.s_transaction_source').hide()
    if $('#s_transaction_operation_type_exit').prop("checked")
      $('.s-tools-fields').show()
      $('.s_transaction_destination').hide()
      $('.s_transaction_source').hide()