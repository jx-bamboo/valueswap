class CreateUserAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :user_addresses do |t|
      t.integer :network # 协议网络
      t.string :w_address, null: false, index: {unique: true} # 绑定的地址
			t.string :symbol 
			t.string :name 
      t.decimal :balance
      t.references :user, null: false, foreign_key: true
      t.references :address, null: false, foreign_key: true

      t.timestamps
    end
  end
end
