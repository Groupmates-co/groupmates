class ChangeUsersAdmin < ActiveRecord::Migration
  def change
  	change_column :users, :admin, :integer
  end
end
