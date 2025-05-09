class CreateTransfers < ActiveRecord::Migration[8.0]
  def change
    create_table :transfers do |t|
      t.integer :transfer_type # withdraw, deposite
      t.string :network # 协议网络
      t.string :txid, index: {unique: true}
      t.string :coin
      t.decimal :amount
      t.string :from_address
			t.string :to_address
			t.integer :status
			t.datetime :confirmed_at
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
