class RemoveInvitableFromUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove_references :invited_by, :polymorphic => true
      t.remove :invitations_count, :invitation_limit, :invitation_sent_at, :invitation_accepted_at, :invitation_token, :invitation_created_at
    end
  end
end
