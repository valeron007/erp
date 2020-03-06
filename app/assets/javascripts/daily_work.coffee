$ ->
  fields = $('.kpi_fields')
  fields.on 'cocoon:before-insert', (e, o) ->
    o.fadeIn 'slow'
  fields.on 'cocoon:after-insert', (e, o) ->
    $(o).find('select').select2
      minimumResultsForSearch: 20
  fields.on 'cocoon:before-remove', (e, o) ->
    $(this).data 'remove-timeout', 1000
    o.fadeOut 'slow'