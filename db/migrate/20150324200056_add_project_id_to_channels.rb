class AddProjectIdToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :project_id, :integer
  end
end
