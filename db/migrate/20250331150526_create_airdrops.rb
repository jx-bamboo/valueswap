class CreateAirdrops < ActiveRecord::Migration[8.0]
  def change
    create_table :airdrops do |t|
      t.string :name # 空頭名稱， 幣種名稱
      t.string :symbol # 幣種符號
      t.string :logo # 空頭logo
      t.string :intro # 空頭簡介
      t.string :official_web # 官方網站
      t.string :total_amount # 項目總量
      t.string :reward_amount # 獎勵數量
      t.string :network # 區塊鏈網路
      t.string :tag # 標籤
      t.json :financing # 融資狀況
      t.string :eligibility
      t.datetime :begin_time # 開始時間
      t.datetime :end_time # 結束時間
      t.integer :status # 狀態 0:未開始 1:進行中 2:已結束
			t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
