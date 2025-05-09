class CreateFundPurchases < ActiveRecord::Migration[8.0]
  def change
    create_table :fund_purchases do |t|
      t.decimal :quantity
      t.decimal :price
      t.decimal :total_amount
      t.string :contract_hash
      t.references :user, null: false, foreign_key: true
      t.references :fund, null: false, foreign_key: true

      t.timestamps
    end
  end
end
