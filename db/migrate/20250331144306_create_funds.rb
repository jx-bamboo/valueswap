class CreateFunds < ActiveRecord::Migration[8.0]
  def change
    create_table :funds do |t|
      t.string :logo # 基金logo
      t.string :name # 基金名称
      t.decimal :price # 基金价格, 起步投资金额
			t.integer :quantity # 基金数量
      t.text :description # 基金描述
      t.datetime :start_time # 基金开始时间
      t.datetime :end_time # 基金结束时间
      t.string :trade_type # 交易类型
      t.string :status, default: 0, null: false # 基金状态
      t.string :official_web # 基金官网
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
