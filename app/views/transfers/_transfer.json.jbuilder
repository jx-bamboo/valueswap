json.extract! transfer, :id, :transfer_type, :txid, :coin, :amount, :network, :address, :user_id, :address_id, :created_at, :updated_at
json.url transfer_url(transfer, format: :json)
