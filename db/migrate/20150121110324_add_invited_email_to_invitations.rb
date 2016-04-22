class AddInvitedEmailToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :invited_email, :string
  end
end
