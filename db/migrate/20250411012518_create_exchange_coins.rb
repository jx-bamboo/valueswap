class CreateExchangeCoins < ActiveRecord::Migration[8.0]
  def change
    create_table :exchange_coins do |t|
      t.references :exchange, null: false, foreign_key: true
      t.references :coin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
