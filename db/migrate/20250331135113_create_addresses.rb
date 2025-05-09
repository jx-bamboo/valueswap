class CreateAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :addresses do |t|
      t.integer :network, null: false # 0 eth
      t.string :address, null: false, index: {unique: true}
      t.string :pri_key_encrypted, index: {unique: true}
      t.integer :status, default: 0, null: false # 0 unused, 1 active
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
