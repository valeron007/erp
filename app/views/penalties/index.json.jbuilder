json.array!(@penalties) do |penalty|
  json.extract! penalty, :id, :name, :penalty_rate
  json.url penalty_url(penalty, format: :json)
end
