class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.references :invited_by, index: true
      t.references :project, index: true
      t.integer :status
      t.string :invitation_token

      t.timestamps null: false
    end
  end
end
