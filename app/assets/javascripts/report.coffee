$ ->
  $('#main-content').on 'click', '.btn-export, .btn-preview', (e) ->
    form = $('.form')
    if $(this).hasClass('btn-export')
      form.removeAttr 'data-remote'
      form.removeData 'remote'
    else
      form.attr 'data-remote', 'true'
    form.attr 'action', $(this).data('action-url')
    form.submit()
  $('input.daterange').daterangepicker
    autoUpdateInput: false,
    alwaysShowCalendars: true,
    opens: 'left',
    locale:
      format: 'DD.MM.YYYY',
      separator: ' - ',
      applyLabel: 'Применить',
      cancelLabel: 'Очистить',
      weekLabel: 'Н',
      customRangeLabel: 'Выбор вручную'
      daysOfWeek: ["Вс", "Пн", "Вт", "Ср", "Чт", "Пт", "Сб"],
      monthNames: ["Янв", "Фев", "Мар", "Апр", "Май", "Июн", "Июл", "Авг", "Сен", "Окт", "Ноя", "Дек"],
      firstDay: 1
    ranges:
      '1-15 предыдущий': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').startOf('month').add(14, 'days')],
      '16-31 предыдущий': [moment().subtract(1, 'month').startOf('month').add(15, 'days'), moment().subtract(1, 'month').endOf('month')],
      'Предыдущий месяц': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
      '1-15 текущий': [moment().startOf('month'), moment().startOf('month').add(14, 'days')],
      '16-31 текущий': [moment().startOf('month').add(15, 'days'), moment().endOf('month')],
      'Текущий месяц': [moment().startOf('month'), moment().endOf('month')],

  $('input.daterange').on 'apply.daterangepicker', (ev, picker) ->
    $(this).val(picker.startDate.format('DD.MM.YYYY') + ' - ' + picker.endDate.format('DD.MM.YYYY'))

  $('input.daterange').on 'cancel.daterangepicker', ->
    $(this).val('')
  $('#btn-preview').on 'click', ->
    $p = $('#calc_preview').empty()

    #WORK
    $t = $('<table/>').addClass('table')

    $p.append $('<h4/>').text 'Работы'

    $row = $('<tr/>')
    $row.append $('<th/>').text 'Наименование'
    $row.append $('<th/>').text 'Кол-во'
    $row.append $('<th/>').text 'Стоимость'

    $t.append $row

    $('.work_fields').find('.nested-fields').each ->
      $row = $('<tr/>')
      $row.append $('<td/>').text $(@).find('.facility_facility_work_types_work_type select option:selected').text()
      $row.append $('<td/>').text $(@).find('.facility_facility_work_types_amount input').val()
      $row.append $('<td/>').text $(@).find('.facility_facility_work_types_total_price input').val()
      $t.append $row

    $p.append $t
    #END


    #TOOLS
    $p.append $('<h4/>').addClass('break-before').text 'Инструменты'
    $t = $('<table/>').addClass('table')

    $row = $('<tr/>')
    $row.append $('<th/>').text 'Наименование'
    $row.append $('<th/>').text 'Кол-во'

    $t.append $row

    $('.tool_fields').find('.nested-fields').each ->
      $row = $('<tr/>')
      $row.append $('<td/>').text $(@).find('.facility_facility_tools_tool select option:selected').text()
      $row.append $('<td/>').text $(@).find('.facility_facility_tools_amount input').val()
      $t.append $row

    $p.append $t
    #END

    #MATERIALS
    $p.append $('<h4/>').addClass('break-before').text 'Материалы'
    $t = $('<table/>').addClass('table')

    $row = $('<tr/>')
    $row.append $('<th/>').text 'Наименование'
    $row.append $('<th/>').text 'Кол-во'
    $row.append $('<th/>').text 'Стоимость'

    $t.append $row

    $('.material_fields').find('.nested-fields').each ->
      $row = $('<tr/>')
      $row.append $('<td/>').text $(@).find('.facility_facility_materials_material select option:selected').text()
      $row.append $('<td/>').text $(@).find('.facility_facility_materials_amount input').val()
      $row.append $('<td/>').text $(@).find('.facility_facility_materials_total_price input').val()
      $t.append $row

    $p.append $t
    #END

    #OTHERS
    $p.append $('<h4/>').addClass('break-before').text 'Инвентарь'
    $t = $('<table/>').addClass('table')

    $row = $('<tr/>')
    $row.append $('<th/>').text 'Наименование'
    $row.append $('<th/>').text 'Кол-во'
    $row.append $('<th/>').text 'Стоимость'

    $t.append $row

    $('.other_fields').find('.nested-fields').each ->
      $row = $('<tr/>')
      $row.append $('<td/>').text $(@).find('.facility_facility_others_other select option:selected').text()
      $row.append $('<td/>').text $(@).find('.facility_facility_others_amount input').val()
      $row.append $('<td/>').text $(@).find('.facility_facility_others_total_price input').val()
      $t.append $row

    $p.append $t
    #END

    #ADDITIONALS
    $p.append $('<h4/>').addClass('break-before').text 'Прочее'
    $t = $('<table/>').addClass('table')

    $row = $('<tr/>')
    $row.append $('<th/>').text 'Наименование'
    $row.append $('<th/>').text 'Кол-во'
    $row.append $('<th/>').text 'Стоимость'

    $t.append $row

    $('.additional_fields').find('.nested-fields').each ->
      $row = $('<tr/>')
      $row.append $('<td/>').text $(@).find('.facility_facility_additionals_additional select option:selected').text()
      $row.append $('<td/>').text $(@).find('.facility_facility_additionals_amount input').val()
      $row.append $('<td/>').text $(@).find('.facility_facility_additionals_total_price input').val()
      $t.append $row

    $p.append $t
    #END
