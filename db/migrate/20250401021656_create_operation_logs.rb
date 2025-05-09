class CreateOperationLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :operation_logs do |t|
      t.string :operation_type
      t.string :detail
      t.string :ip
      t.string :user_agent
      t.references :user, foreign_key: true, null: true

      t.timestamps
    end
  end
end
