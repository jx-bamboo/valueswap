class CreateUserExchanges < ActiveRecord::Migration[8.0]
  def change
    create_table :user_exchanges do |t|
      t.string :api_key, index: {unique: true}
      t.string :api_secret, index:  {unique: true}
      t.string :memo
      t.integer :status, default: 0, null: false
      t.references :user, null: false, foreign_key: true
      t.references :exchange, null: false, foreign_key: true

      t.timestamps
    end
  end
end
