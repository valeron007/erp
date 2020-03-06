json.array!(@positions) do |position|
  json.extract! position, :id, :title
  json.url position_url(position, format: :json)
end
