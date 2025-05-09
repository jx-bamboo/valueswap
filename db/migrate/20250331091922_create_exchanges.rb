class CreateExchanges < ActiveRecord::Migration[8.0]
  def change
    create_table :exchanges do |t|
      t.string :name, index: {unique: true}
      t.string :logo
			t.string :official_web
			t.text :description
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
