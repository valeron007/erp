json.array!(@work_types) do |work_type|
  json.extract! work_type, :id, :name, :unit, :price_per_unit, :facility_id
  json.url work_type_url(work_type, format: :json)
end
