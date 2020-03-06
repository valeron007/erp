$ ->
  global_o = null
  $('#export_to_excel').on 'click', (e) ->
    location.href=$(this).data('url') + '?' + $('#filterrific_filter').serialize()
  $('#daily_timesheet_employee_id').on 'change',  (e) ->
    $.get "/employees/" + $(this).val() + ".json", (data) ->

      salary = 0
      salary = data.salary if data.salary
      $('#daily_timesheet_salary').val(salary)

      ratio = 1
      ratio = data.salary_ratio if data.salary_ratio
      $('#daily_timesheet_ratio').val(ratio)

      probation_period = 0
      probation_period = data.probation_period if data.probation_period

      res = moment().isBefore(moment(data.hire_date).add(probation_period, 'day'))
      $('#daily_timesheet_probation_period').prop('checked', res)
      $('#daily_timesheet_probation_period_h').val(res)

      #TODO добавляем 300р бригадирам
      if(data && data.position_id == 7)
        $('#daily_timesheet_additional_payment_value').val(300)
        $('#daily_timesheet_additional_payment_reason').val('Бригадир')

      $('form.simple_form').trigger 'bms:change'

  $('#daily_timesheet_date').on 'change',  (e) ->
    cur_date = moment($(this).val(), "DD.MM.YYYY")
    end_date = moment($(this).val(), "DD.MM.YYYY").startOf('month').add(2, 'w')
    start_date = moment($(this).val(), "DD.MM.YYYY").startOf('month')

    if cur_date.isBetween(start_date, end_date, null, '[]')
      $('#daily_timesheet_salary_period_id').val(1).trigger("change")
    else
      $('#daily_timesheet_salary_period_id').val(2).trigger("change")

  $('#daily_timesheet_no_work').on 'click',  (e) ->
    if $(@).prop('checked')
      $('.no-work').hide()
    else
      $('.no-work').show()

  fields = $('.work_fields, .penalties')

  fields.on 'cocoon:after-remove', (e, o) ->
    $('form.simple_form').trigger 'bms:change'

  class Calculator
    hpd: 10
    ratio: '#daily_timesheet_ratio'
    salary: '#daily_timesheet_salary'
    salary_type: '#daily_timesheet_payment_type_id'
    probation: '#daily_timesheet_probation_period'
    start_time: '#daily_timesheet_start_time'
    end_time: '#daily_timesheet_end_time'
    overtime: '#daily_timesheet_overtime'
    nested_select: '.nested-fields select'
    nested_input: '.nested-fields input.s-amount'
    total: '#daily_timesheet_total_amount'
    penalties: '.penalty-select'
    employee: '#daily_timesheet_employee_id'
    additional: '#daily_timesheet_additional_payment_value'

    getSalaryType: ->
      result = parseInt($(@salary_type).val())
      result ||= 1
    parseTime: (selector) ->
      moment($(selector).val(),'HH:mm:ss')
    getTotalHours: ->
      stime = @parseTime(@start_time)
      etime = @parseTime(@end_time)
      if stime.isAfter(etime)
        etime = etime.add(24, 'hours')
      moment.duration(etime.diff(stime)).asHours()
    getSelectVal: (selector) ->
      result = parseFloat($(selector).find(':selected').data('price'))
      result ||= 0
    getRatio: (selector = @ratio) ->
      result = parseFloat($(selector).val())
      result ||= 1
    getTotal: ->
      piecework = 0;
      $('.work_fields > .nested-fields').each (idx, element) =>
        amount = parseFloat($(element).find('input.s-amount').val())
        amount = 0 if isNaN amount
        piecework += @getSelectVal(element) * amount;

      penalties = 0;
      $(@penalties).each (idx, element) =>
        penalties += @getSelectVal(element);

      sph = Math.floor($(@salary).val()/@hpd)

      hrs = @getTotalHours()

      l = @getRatio()

      k = 1
      m = 0
      if @getSalaryType() == 2
        k = 0
        m = 1

      add = parseFloat($(@additional).val())
      add = 0 if isNaN add

      #console.log('piecework='+piecework)
      #console.log('k='+k)
      #console.log('sph='+sph)
      #console.log('hrs='+hrs)
      #console.log('m='+m)
      #console.log('l='+l)
      #console.log(penalties)
      #console.log(add)
      total = (piecework * k + sph * hrs * m) * l + add - penalties
      #console.log(total)
    setTotal: ->
      $(@total).val(@getTotal())

  $(document).on 'bms:change', 'form.simple_form', (e) ->
    calc = new Calculator()
    calc.setTotal();

  keyup = []
  keyup.push Calculator::ratio
  keyup.push Calculator::salary
  keyup.push Calculator::start_time
  keyup.push Calculator::end_time
  keyup.push Calculator::nested_input
  keyup.push Calculator::additional
  change = []
  change.push Calculator::nested_select
  change.push Calculator::salary_type
  change.push Calculator::penalties
  change.push Calculator::employee
  change.push Calculator::start_time
  change.push Calculator::end_time

  $('form.simple_form').on 'keyup', keyup.toString(), (e) ->
    $(this).trigger 'bms:change'
  $('form.simple_form').on 'change', change.toString(), (e) ->
    $(this).trigger 'bms:change'
  $('form.simple_form').on 'click', '.recalculate', (e) ->
    $(this).trigger 'bms:change'

  false