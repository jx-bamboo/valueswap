class CreateUserExchangeCoins < ActiveRecord::Migration[8.0]
  def change
    create_table :user_exchange_coins do |t|
      t.decimal :balance
      t.datetime :last_updated
      t.integer :status, default: 0, null: false
      t.references :user, null: false, foreign_key: true
      t.references :exchange, null: false, foreign_key: true
      t.references :coin, null: false, foreign_key: true
      t.timestamps
    end
  end
end
