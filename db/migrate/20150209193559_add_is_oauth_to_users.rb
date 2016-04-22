class AddIsOauthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_oauth, :boolean
  end
end
