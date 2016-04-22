class AddLastNotifiedAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_notified_at, :datetime
  end
end
