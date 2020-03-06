json.extract! adoc_status, :id, :name, :color, :order, :created_at, :updated_at
json.url adoc_status_url(adoc_status, format: :json)