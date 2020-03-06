json.extract! s_material, :id, :name_id, :pack, :amount, :unit_id, :min_amount, :storage_place, :comments, :created_at, :updated_at
json.url s_material_url(s_material, format: :json)