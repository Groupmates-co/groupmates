class AddChannelIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :channel_id, :integer
  end
end
