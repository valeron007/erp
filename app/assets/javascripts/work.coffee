$ ->
  fields = $('.tool_fields, .material_fields, .work_type_categories_fields')
  fields.on 'cocoon:before-insert', (e, o) ->
    o.fadeIn 'slow'
  fields.on 'cocoon:after-insert', (e, o) ->
    $(o).find('select').select2
      language: "ru"
      minimumResultsForSearch: 20
      allowClear: true
      placeholder: "Выбрать значение"
  fields.on 'cocoon:before-remove', (e, o) ->
    $(this).data 'remove-timeout', 1000
    o.fadeOut 'slow'