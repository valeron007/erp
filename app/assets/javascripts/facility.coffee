$ ->
  global_o = null
  UpdateTotal = (group) ->
    if group
      price = parseFloat(group.find('.s-object').find(':selected').data('price'))
      price ||= 0
      amount = parseFloat(group.find('.s-amount').val())
      amount ||= 0
      group.find('.s-total').val((price*amount).toFixed(2))
  fields = $('.adoc_fields, .cost_fields, .material_fields, .tool_fields, .work_fields, .other_fields, .additional_fields, .d_name_fields')
  fields.on 'cocoon:before-insert', (e, o) ->
    o.fadeIn 'slow'
  fields.on 'cocoon:after-insert', (e, o) ->

    if global_o
      object = $(o).find('.s-object')
      amount = $(o).find('.s-amount')
      if global_o.tool_id
        object.val(global_o.tool_id)
      else if global_o.material_id
        object.val(global_o.material_id)
      else if global_o.other_id
        object.val(global_o.other_id)
      else if global_o.additional_id
        object.val(global_o.additional_id)
      else if global_o.work_type_id
        object.val(global_o.work_type_id)
      if global_o.amount
        amount.val(global_o.work_amount * global_o.amount)
      else
        amount.val(1)

      UpdateTotal $(o)

      global_o = null;

    $(o).find('select:not(.select2-tags)').select2
      language: "ru"
      minimumResultsForSearch: 20
      allowClear: true
      placeholder: "Выбрать значение"
    $(o).find('select.select2-tags').select2
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
    $(o).find('.datepicker').datepicker
      format: 'dd.mm.yyyy'
      todayHighlight: true
      weekStart: 1
      language: "ru"
      autoclose: true
  fields.on 'cocoon:before-remove', (e, o) ->
    $(this).data 'remove-timeout', 1000
    o.fadeOut 'slow'
  
  $(document).on 'change', '.work_fields > .nested-fields select.s-object, .work_fields > .nested-fields input.s-amount, .material_fields > .nested-fields select.s-object, .material_fields > .nested-fields input.s-amount, .other_fields > .nested-fields select.s-object, .other_fields > .nested-fields input.s-amount, .additional_fields > .nested-fields select.s-object, .additional_fields > .nested-fields input.s-amount', (e) ->
    UpdateTotal $(e.target).closest('.nested-fields')

  FillParts = (work_amount, parts, link, text) ->
    AddPart(work_amount, part, link, text) for part in parts
    AddWorkCategoryToWorkType(text, type, i) for type, i in $('.work-category')

  AddPart = (work_amount, o, link) ->
    global_o = o
    global_o.work_amount = parseFloat(work_amount) || 1
    $(link).click()

  AddWorkCategoryToWorkType = (category, type, i) ->
    type.textContent = "#{i + 1}. #{category}"

  $('#calc_tools, #calc_materials, #calc_others, #calc_additionals').on 'click', (e) ->
    e.preventDefault()
    t = e.target
    for work in $('.work_fields > .nested-fields select.s-object')
      do (work) ->
        work_amount = $(work).parents('.nested-fields').find('.s-amount').val()
        if t.id == 'calc_tools'
          FillParts work_amount, $(work).find(':selected').data('tools'), '.add-tool'
        if t.id == 'calc_materials'
          FillParts work_amount, $(work).find(':selected').data('materials') , '.add-material'
        if t.id == 'calc_others'
          FillParts work_amount, $(work).find(':selected').data('others') , '.add-other'
        if t.id == 'calc_additionals'
          FillParts work_amount, $(work).find(':selected').data('additionals') , '.add-additional'
  $('#clear_tools, #clear_materials, #clear_others, #clear_additionals, #clear_works').on 'click', (e) ->
    e.preventDefault()
    t = e.target
    if t.id == 'clear_tools'
      $('.tool_fields a.remove_fields').click()
    if t.id == 'clear_materials'
      $('.material_fields a.remove_fields').click()
    if t.id == 'clear_others'
      $('.other_fields a.remove_fields').click()
    if t.id == 'clear_additionals'
      $('.additional_fields a.remove_fields').click()
    if t.id == 'clear_works'
      $('.work_fields a.remove_fields').click()

  $('#calc_works').on 'click', (e) ->
    e.preventDefault()
    FillParts $('#work_amount').val(), $('#work_category_id').find(':selected').data('works'), '.add-work', $('#work_category_id').find(':selected').text()
  false