class CreateExchangeBalances < ActiveRecord::Migration[8.0]
  def change
    create_table :exchange_balances do |t|
      t.decimal :spot, precision: 20, scale: 8, null: false, default: 0.0
      t.decimal :funding, precision: 20, scale: 8, null: false, default: 0.0
      t.decimal :usd_futures, precision: 20, scale: 8, null: false, default: 0.0
      t.json :ex_json, null: false, default: {}
      t.text :ex_text
      t.references :user, null: false, foreign_key: true
      t.references :user_exchange, null: false, foreign_key: true
      t.timestamps
    end
  end
end
