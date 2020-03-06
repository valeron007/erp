json.array!(@employees) do |employee|
  json.extract! employee, :id, :first_name, :last_name, :middle_name, :position_id, :hire_date, :probation_period, :employee_status_id, :fire_date, :fire_reason_id, :passport, :birth_date, :citizenship, :nationality, :felony, :felony_notes, :salary, :salary_ratio, :card_number, :card_owner, :shoes_size, :dress_size, :height, :children_count, :mobile_number, :phone_number, :address, :residential_address, :emergency_name, :emergency_phone
  json.url employee_url(employee, format: :json)
end
