select
  f.id           as facility_id,
  f.name         as facility_name,
  e.id           as employee_id,
  e.last_name    as employee_last_name,
  e.first_name   as employee_first_name,
  e.middle_name  as employee_middle_name,
  w.id           as work_id,
  w.name         as work_name,
  max(w.price_per_unit)   as work_price,
  sum(dw.amount) as work_amount
from daily_timesheets d
  left join daily_timesheet_work_types dw on dw.daily_timesheet_id = d.id
  left join work_types w on dw.work_type_id = w.id
  left join employees e on d.employee_id = e.id
  left join facilities f on d.facility_id = f.id

where
  d.daily_timesheet_status_id > %{draft_status_id}
  and coalesce(%{facility_id}, f.id) = f.id
  and d.date >= coalesce(%{date_from}, d.date)
  and d.date <= coalesce(%{date_to}, d.date)
  and lower(e.last_name) like %{employee_name}
group by 1,2,3,4,5,6,7,8
order by d.facility_id, d.date, lower(e.last_name)