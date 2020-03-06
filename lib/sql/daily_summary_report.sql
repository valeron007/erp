select
  d.date                                          as report_date,
  count(distinct d.employee_id)                   as employee_count,
  count(distinct d.facility_id)                   as facility_count,
  group_concat(distinct f.name separator ' / ')   as facility_list
from daily_timesheets d
  left join facilities f on d.facility_id = f.id
where
  d.daily_timesheet_status_id > %{draft_status_id}
  and coalesce(%{facility_id}, f.id) = f.id
  and d.date >= coalesce(%{date_from}, d.date)
  and d.date <= coalesce(%{date_to}, d.date)
group by 1
order by d.date