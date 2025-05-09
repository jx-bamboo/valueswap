class CreateCoins < ActiveRecord::Migration[8.0]
  def change
    create_table :coins do |t|
		  t.string :symbol, index: { unique: true } # 简称
			t.string :name, index: { unique: true } # 全称
			t.string :quote_coin # 报价货币： USDT
      t.string :logo # icon logo
      t.integer :status, default: 0, null: false
      t.timestamps
    end
  end
end
