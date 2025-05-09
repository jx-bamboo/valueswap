json.extract! trade, :id, :trade_type, :action, :price, :quantity, :total_amount, :fee, :status, :profit_loss, :order_id, :executed_at, :admin_id, :user_id, :user_exchange_id, :coin_id, :created_at, :updated_at
json.url trade_url(trade, format: :json)
