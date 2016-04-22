class CreateChannelsUsers < ActiveRecord::Migration
  def change
    create_table :channels_users, :id => false do |t|
      t.belongs_to :channel, index: true
      t.belongs_to :user, index: true
    end
  end
end
