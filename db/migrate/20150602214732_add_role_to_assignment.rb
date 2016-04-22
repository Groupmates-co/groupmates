class AddRoleToAssignment < ActiveRecord::Migration
  def change
    add_column :projects_users, :role, :string
  end
end
