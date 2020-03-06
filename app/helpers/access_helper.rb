module AccessHelper

  def has_employees_access
    policy(:employee).index?
  end

  def has_daily_timesheets_access
    policy(:daily_timesheet).index?
  end

  def has_leads_access
    policy(:lead).index?
  end

  def has_deliveries_access
    policy(:delivery).index?
  end

  def has_storage_access
    has_s_materials_access or
    has_s_tools_access or
    has_s_others_access or
    has_s_additionals_access or
    has_s_transactions_access
  end

  def has_storage_widget_access
    has_storage_access
  end

  def has_clients_access
    policy(:client).index?
  end

  def has_reports_access
    has_dashboard_report_access or
    has_employee_payments_report_access or
    has_facility_works_report_access or
    has_labor_costs_report_access or
    has_work_efficiency_report_access or
    has_daily_summary_report_access or
    has_calc_report_access
  end

  def has_dashboard_report_access
    policy(:report).dashboard?
  end

  def has_employee_payments_report_access
    policy(:report).employee_payments?
  end

  def has_facility_works_report_access
    policy(:report).facility_works?
  end

  def has_labor_costs_report_access
    policy(:report).labor_costs?
  end

  def has_work_efficiency_report_access
    policy(:report).work_efficiency?
  end

  def has_daily_summary_report_access
    policy(:report).daily_summary?
  end

  def has_calc_report_access
    policy(:report).calc?
  end

  def has_positions_access
    policy(:position).index?
  end

  def has_facilities_access
    policy(:facility).index?
  end

  def has_work_types_access
    policy(:work_type).index?
  end

  def has_work_categories_access
    policy(:work_category).index?
  end

  def has_works_access
    policy(:work_category).index? or policy(:work_category).index?
  end

  def has_units_access
    policy(:unit).index?
  end

  def has_contractors_access
    policy(:contractor).index?
  end

  def has_transport_companies_access
    policy(:transport_company).index?
  end

  def has_delivery_letters_access
    policy(:delivery_letter).index?
  end

  def has_materials_access
    policy(:material).index?
  end

  def has_additional_access
    policy(:additional).index?
  end

  def has_tools_access
    policy(:tool).index?
  end

  def has_others_access
    policy(:other).index?
  end

  def has_inventory_type_access
    policy(:inventory_type).index?
  end

  def has_warehouse_access
    has_tools_access or
    has_materials_access or
    has_others_access or
    has_additional_access or
    has_inventory_type_access
  end

  def has_penalties_access
    policy(:penalty).index?
  end

  def has_users_access
    policy(:user).index?
  end

  def has_call_records_access
    policy(:user).index?
  end

  def has_management_access
    has_employees_access or
    has_clients_access or
    has_tasks_access or
    has_expenses_access or
    has_documents_access
  end

  def has_referenses_access
    has_positions_access or
    has_penalties_access or
    has_clients_access or
    has_adoc_statuses_access or
    has_adoc_names_access or
    has_units_access or
    has_work_categories_access or
    has_work_types_access or
    has_contractors_access or
    has_transport_companies_access or
    has_delivery_letters_access or
    has_users_access or
    has_warehouse_access or
    has_contact_access
  end

  def has_adoc_statuses_access
    policy(:adoc_status).index?
  end

  def has_adoc_names_access
    policy(:adoc_name).index?
  end

  def has_dob_widget_access
    current_user.admin_role?
  end

  def has_lead_widget_access
    policy(:lead).index?
  end

  def has_task_widget_access
    true
  end

  def has_delivery_widget_access
    has_deliveries_access
  end

  def has_lead_full_access
    policy(:lead).has_full_access?
  end

  def has_documents_access
    policy(:document).index?
  end

  def has_tasks_access
    policy(:task).index?
  end

  def can_change_task_owner(record)
    policy(record).can_create?
  end

  def can_assign_task(record)
    policy(record).can_create?
  end

  def can_update_task(record)
    policy(record).can_edit?
  end

  def can_delete_task(record)
    policy(record).can_delete?
  end

  def has_expenses_access
    policy(:expense).index?
  end

  def has_s_materials_access
    policy(:s_material).index?
  end

  def has_s_tools_access
    policy(:s_tool).index?
  end

  def has_s_others_access
    policy(:s_other).index?
  end

  def has_s_additionals_access
    policy(:s_additional).index?
  end

  def has_s_transactions_access
    policy(:s_transaction).index?
  end

  def can_assign_expense
    policy(:expense).can_assign?
  end

  def can_search_by_user
    current_user.admin_role?
  end

  def has_kpi_access
    policy(:kpi).index?
  end

  def has_daily_work_access
    policy(:daily_work).index?
  end

  def can_assign_daily_work
    policy(:daily_work).can_assign?
  end

  def has_contact_access
    policy(:contact).index?
  end

end
