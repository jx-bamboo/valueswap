class CreateInvitations < ActiveRecord::Migration[8.0]
  def change
    create_table :invitations do |t|
      t.integer :invitee_id # 被邀請人
			t.string :invitation_code # 邀请人的邀请码
			t.integer :status, default: 0, null: false
      t.references :user, null: false, foreign_key: true # 邀請人

      t.timestamps
    end
  end
end
