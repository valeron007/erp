json.extract! document, :id, :name, :content, :created_by_id, :updated_by_id, :created_at, :updated_at
json.url document_url(document, format: :json)