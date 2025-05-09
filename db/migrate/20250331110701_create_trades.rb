class CreateTrades < ActiveRecord::Migration[8.0]
  def change
    create_table :trades do |t|
      t.string :trade_type, null: false, default: 'manual' # manual, quant, ai 买卖类型
      t.string :side, null: false # buy, sell 买卖
      t.string :order_type, null: false, default: 'limit' # limit, market 限价单，市价单
      t.decimal :price, precision: 15, scale: 8, null: false
      t.decimal :quantity, precision: 15, scale: 8, null: false
      t.decimal :fee, precision: 15, scale: 8, default: 0.0, null: false
      t.string :status, null: false, default: 'pending' # pending, filled, cancelled, failed
      t.decimal :profit_loss, precision: 15, scale: 8, default: 0.0 # 盈亏
      t.integer :leverage, default: 1 # 合约交易，杠杆倍数
      t.string :position_side # long, short (合约专用) 多，空
      t.string :order_id, null: false, index: { unique: true } # 交易所订单ID
      t.datetime :executed_at, null: false # 交易时间
      t.string :method # spot, margin, futures
      t.json :ex_json, null: false, default: {}
      t.text :ex_text
      t.references :user, null: false, foreign_key: true, index: true
      t.references :exchange, null: false, foreign_key: true, index: true
      t.references :user_exchange, null: false, foreign_key: true
      t.references :coin, null: true, foreign_key: true, index: true
      t.references :admin, foreign_key: { to_table: :users } # 可为空

      t.timestamps
    end

    add_index :trades, :status
    add_index :trades, :executed_at
  end
end