module ApplicationHelper

  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info", warning: "alert-warning" }[flash_type.to_sym] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} alert-dismissible") do
        concat content_tag(:button, '×', class: "close", data: { dismiss: 'alert' })
        concat message
      end)
    end
    nil
  end

  def h_localize_date(src_date)
    I18n.localize(src_date) if src_date
  end
  def h_localize_datetime(src_time)
    I18n.localize(src_time) if src_time
  end
  def h_time(src_time)
    src_time.strftime("%H:%M") if src_time
  end

  def human_date(src_date)
    human_date_format(src_date, "%-d %B, %Y")
  end
  def human_date_format(src_date, format)
    I18n.localize(src_date, :format => format) if src_date
  end

  def h_decimal(d)
    number_with_precision(d, precision: 3) if d
  end

  def count_assigned_tasks(user)
    @tasks_count ||= Task.assigned_to(user).assigned.count
  end

  class BootstrapLinkRenderer < ::WillPaginate::ActionView::LinkRenderer
    protected

    def html_container(html)
      tag :ul, html, container_attributes
    end

    def page_number(page)
      tag :li, link(page, page, :rel => rel_value(page)), :class => ('active' if page == current_page)
    end

    def gap
      tag :li, link(super, '#'), :class => 'disabled'
    end

    def previous_or_next_page(page, text, classname)
      tag :li, link(text, page || '#'), :class => [classname[0..3], classname, ('disabled' unless page)].join(' ')
    end
  end

  def page_navigation_links(pages)
    will_paginate(pages, :class => 'pagination', :inner_window => 2, :outer_window => 0, :renderer => BootstrapLinkRenderer, :previous_label => '&larr;'.html_safe, :next_label => '&rarr;'.html_safe)
  end
end
