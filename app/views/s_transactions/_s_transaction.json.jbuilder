json.extract! s_transaction, :id, :date, :destination_id, :user_from_id, :user_to_id, :comments, :created_at, :updated_at
json.url s_transaction_url(s_transaction, format: :json)