class DatePickerInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    template.content_tag(:div, class: 'has-icon date') do
      template.concat @builder.text_field(attribute_name, input_html_options)
      template.concat icon_calendar
    end
  end

  def input_html_options
    super.merge({class: 'form-control datepicker'})
  end

  def icon_calendar
    "<span class='glyphicon glyphicon-calendar form-control-icon'></span>".html_safe
  end

end
